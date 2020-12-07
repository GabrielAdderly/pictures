import 'package:flutter/material.dart';

mixin InitAnimationMixin<T extends StatefulWidget> on State<T> {
  Animation animateTopPadding;
  Animation animateEvenRightPadding;
  Animation animateUnevenLeftPadding;
  Animation animateUnevenRightPadding;
  AnimationController topPaddingController;
  AnimationController rightEvenPaddingController;
  AnimationController leftUnevenPaddingController;
  AnimationController rightUnevenPaddingController;
  final ScrollController scrollController = ScrollController();

  bool wasChecked = false;
  bool showDebugPrints = false;
  bool isAnimatedForward = true;

  double halfOfPrimaryWidth;
  double cardHeightWithPadding;

  int gridScrollMultiplier = 0;
  int listScrollMultiplier = 0;
  double savedGridOffset = 0.0;
  double savedListOffset = 0.0;
  double viewsScrollDifference = 0.0;

  Duration duration;


  void initTopPaddingAnimation() {
    AnimationStatus animationStatus;
    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)
      ..addListener(() {
        if (animationStatus == null) _compensateViewScrollChange();
        if (animationStatus == AnimationStatus.forward) {
          print('FORWARD');
          _compensateViewScrollChange();
        }
        if (animationStatus == AnimationStatus.reverse && !isAnimatedForward) {
          _compensateViewScrollChange(reversed: true);
        }
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        animationStatus = status;
        if (status == AnimationStatus.completed) {
          leftUnevenPaddingController.forward();
          rightUnevenPaddingController.forward();
        } else if (status == AnimationStatus.dismissed) {
          print('DONE');
          wasChecked = false;
          isAnimatedForward = true;
          initBufferVariables();
        }
      });
  }

  void initUnevenLeftPaddingAnimation() {
    animateUnevenLeftPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(leftUnevenPaddingController);
  }


  void initUnevenRightPaddingAnimation() {
    animateUnevenRightPadding = Tween<double>(begin: 0, end: halfOfPrimaryWidth).animate(rightUnevenPaddingController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed && isAnimatedForward) {
          rightEvenPaddingController.forward();
          rightUnevenPaddingController.reverse();
        } else if (status == AnimationStatus.dismissed && !isAnimatedForward) {
          print('REVERSE');
          topPaddingController.reverse();
        }
      });
  }

  void initEvenRightPaddingAnimation() {
    animateEvenRightPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(rightEvenPaddingController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          print('DONE');
          initBufferVariables();
        }
        if (status == AnimationStatus.dismissed && !isAnimatedForward) {
          leftUnevenPaddingController.reverse();
          rightUnevenPaddingController.reverse();
        }
      });
  }

  void initBufferVariables() {
    savedGridOffset = 0.0;
    savedListOffset = 0.0;
    gridScrollMultiplier = 0;
    listScrollMultiplier = 0;
    viewsScrollDifference = 0.0;
  }


  void _compensateViewScrollChange({bool reversed = false}) {
    if (savedGridOffset == 0.0) savedGridOffset = scrollController.offset;
    if (viewsScrollDifference == 0.0) viewsScrollDifference = savedGridOffset % cardHeightWithPadding;
    if (gridScrollMultiplier == 0) gridScrollMultiplier = scrollController.offset ~/ cardHeightWithPadding;

    if (reversed) {
      if (savedListOffset == 0.0) {
        savedListOffset = (scrollController.offset - viewsScrollDifference) / 2 + viewsScrollDifference;
      }
      if (listScrollMultiplier == 0) listScrollMultiplier = scrollController.offset ~/ (2 * cardHeightWithPadding);

      printDebug();
      _jumpTo(savedListOffset, listScrollMultiplier);
    } else {
      printDebug();
      _jumpTo(savedGridOffset, gridScrollMultiplier);
    }
  }

  void unevenScroll(Function triggerTween) {
    if (savedGridOffset == 0.0) savedGridOffset = scrollController.offset;
    if (savedGridOffset ~/ cardHeightWithPadding % 2 != 0 && !wasChecked) {
      wasChecked = true;

      final Duration scrollToRowDuration = Duration(milliseconds: (duration.inMilliseconds / 4).round());

      scrollController.animateTo(
        savedGridOffset - cardHeightWithPadding,
        duration: scrollToRowDuration,
        curve: Curves.decelerate,
      );

      Future.delayed(scrollToRowDuration, () => triggerTween());
    } else {
      triggerTween();
    }
  }

  void _jumpTo(double offset, int offsetMultiplier) {
    scrollController.jumpTo(offset + animateTopPadding.value * offsetMultiplier);
  }

  void printDebug() {
    if (showDebugPrints) {
      print('Current offset ${scrollController.offset}');
      print('Tween value ${animateTopPadding.value}');
      print('Views scroll difference $viewsScrollDifference');
      print('Saved list offset $savedListOffset');
      print('Saved grid offset $savedGridOffset');
      print('Current compensating jump offset ${savedListOffset + animateTopPadding.value * listScrollMultiplier}');
      print('Card height + padding $cardHeightWithPadding');
      print('List\'s compensating scroll multiplier $listScrollMultiplier');
      print('Grid\'s compensating scroll multiplier $gridScrollMultiplier');
    }
  }
}