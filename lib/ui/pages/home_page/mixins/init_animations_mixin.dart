import 'package:flutter/material.dart';

mixin InitAnimationMixin<T extends StatefulWidget> on State<T> {
  //region [Animations & Controllers]
  Animation animateTopPadding;
  Animation animateEvenRightPadding;
  Animation animateUnevenLeftPadding;
  Animation animateUnevenRightPadding;
  AnimationController topPaddingController;
  AnimationController rightEvenPaddingController;
  AnimationController leftUnevenPaddingController;
  AnimationController rightUnevenPaddingController;
  final ScrollController scrollController = ScrollController();
  //endregion

  //region [Scroll Variables]
  ///End top [Tween] value equals to one [cardHeightWithPadding]
  ///Thus [_compensateViewScrollChange] needs a multiplier to scroll properly
  int gridScrollMultiplier = 0;
  int listScrollMultiplier = 0;
  ///Both of the offsets starting values need to be saved so Scroll could be calculated
  double savedGridOffset = 0.0;
  double savedListOffset = 0.0;
  ///[cardInternalPosition] is needed to calculate proper in-card offset position
  double cardInternalPosition = 0.0;
  //endregion

  //region [Other Variables]
  ///The main animation sequence duration
  Duration duration;
  ///Half of the screen width
  double halfOfPrimaryWidth;
  double cardHeightWithPadding;
  ///[wasChecked] is needed to check only once what kind of card is being viewed currently
  ///Used in [unevenScroll] Function
  bool wasChecked = false;
  bool showDebugPrints = false;
  ///Additional check for reverse animation
  bool isAnimatedForward = true;
  //endregion

  ///The Function that animates top padding of the Grid's child widgets
  void initTopPaddingAnimation() {
    ///Additional check variable so Scroll could work in a proper direction
    AnimationStatus animationStatus;
    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)
      ///_compensateViewScrollChange starts in parallel with top padding animation
      ..addListener(() {
        if (animationStatus == AnimationStatus.forward) {
          ///Forward animation sequence entry point
          if (showDebugPrints) print('FORWARD');
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
          ///The end of the reverse animation sequence
          if (showDebugPrints) print('DONE');

          wasChecked = false;
          isAnimatedForward = true;
          initBufferVariables();
        }

      });
  }

  ///This one does not need a [Listener] since it paralleled with UnevenRightPadding animation
  void initUnevenLeftPaddingAnimation() {
    animateUnevenLeftPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(leftUnevenPaddingController);
  }

  ///The Function that animates right padding of the Grid's uneven child widgets
  void initUnevenRightPaddingAnimation() {
    animateUnevenRightPadding = Tween<double>(begin: 0, end: halfOfPrimaryWidth).animate(rightUnevenPaddingController)
      ..addListener(() => setState(() {}))

      ..addStatusListener((AnimationStatus status) {

        if (status == AnimationStatus.completed && isAnimatedForward) {
          rightEvenPaddingController.forward();
          rightUnevenPaddingController.reverse();

        } else if (status == AnimationStatus.dismissed && !isAnimatedForward) {
          ///Reversed animation entry point
          if (showDebugPrints) print('REVERSE');
          topPaddingController.reverse();
        }

      });
  }

  ///The Function that animates right padding of the Grid's even child widgets
  void initEvenRightPaddingAnimation() {
    animateEvenRightPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(rightEvenPaddingController)
      ..addListener(() => setState(() {}))

      ..addStatusListener((AnimationStatus status) {
        ///The end of the forward animation sequence
        if (status == AnimationStatus.completed) {
          if (showDebugPrints) print('DONE');
          initBufferVariables();
        }

        if (status == AnimationStatus.dismissed && !isAnimatedForward) {
          leftUnevenPaddingController.reverse();
          rightUnevenPaddingController.reverse();
        }

      });
  }

  ///Function to reset the scroll values
  void initBufferVariables() {
    savedGridOffset = 0.0;
    savedListOffset = 0.0;
    gridScrollMultiplier = 0;
    listScrollMultiplier = 0;
    cardInternalPosition = 0.0;
  }

  ///Function that compensates size change of the grid/list appearances by it's own scroll
  void _compensateViewScrollChange({bool reversed = false}) {
    ///Checking zeros is needed to save values for one time, not every time when setState is called
    if (savedGridOffset == 0.0) savedGridOffset = scrollController.offset;
    if (cardInternalPosition == 0.0) cardInternalPosition = savedGridOffset % cardHeightWithPadding;
    if (gridScrollMultiplier == 0) gridScrollMultiplier = scrollController.offset ~/ cardHeightWithPadding;

    ///Reverse and forward sequences are different
    ///The appearance of the grid could be changed, scrolled and changed again
    ///Thus both animation sequences can't be same
    if (reversed) {
      if (savedListOffset == 0.0) {
        ///Expression that converts list offset to grid offset
        savedListOffset = (scrollController.offset - cardInternalPosition) / 2 + cardInternalPosition;
      }
      if (listScrollMultiplier == 0) listScrollMultiplier = scrollController.offset ~/ (2 * cardHeightWithPadding);
      _printDebug();
      _jumpTo(savedListOffset, listScrollMultiplier);

    } else {
      _printDebug();
      _jumpTo(savedGridOffset, gridScrollMultiplier);
    }

  }

  ///Function that checks if widget is uneven and animates it in a different way
  ///The even and uneven cards in the grid are placed in one horizontal line
  ///Thus an uneven card in the list form must be scrolled first before running the main animation sequence
  ///If card is even, when scroll animation goes straight to the main animation sequence
  void unevenScroll(Function triggerTween) {
    if (savedGridOffset == 0.0) savedGridOffset = scrollController.offset;
    ///Checks if card is uneven
    if (savedGridOffset ~/ cardHeightWithPadding % 2 != 0 && !wasChecked) {
      wasChecked = true;

      final Duration scrollToRowDuration = Duration(milliseconds: (duration.inMilliseconds / 4).round());

      scrollController.animateTo(
        savedGridOffset - cardHeightWithPadding,
        duration: scrollToRowDuration,
        curve: Curves.decelerate,
      );
      ///Delay before the main animation sequence starts
      Future.delayed(scrollToRowDuration, () => triggerTween());
    } else {
      triggerTween();
    }
  }

  ///The core function of the [_compensateViewScrollChange]
  ///Uses tween value to compensate difference between grid/list appearances
  void _jumpTo(double offset, int offsetMultiplier) {
    scrollController.jumpTo(offset + animateTopPadding.value * offsetMultiplier);
  }

  void _printDebug() {
    if (showDebugPrints) {
      print('Current offset ${scrollController.offset}');
      print('Tween value ${animateTopPadding.value}');
      print('Views scroll difference $cardInternalPosition');
      print('Saved list offset $savedListOffset');
      print('Saved grid offset $savedGridOffset');
      print('Current compensating jump offset ${savedListOffset + animateTopPadding.value * listScrollMultiplier}');
      print('Card height + padding $cardHeightWithPadding');
      print('List\'s compensating scroll multiplier $listScrollMultiplier');
      print('Grid\'s compensating scroll multiplier $gridScrollMultiplier');
    }
  }
}