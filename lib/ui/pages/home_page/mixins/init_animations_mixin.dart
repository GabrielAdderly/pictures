import 'package:flutter/material.dart';

/// [gridScrollMultiplier] All the cards are getting top padding during the animation
/// Thus [_compensateViewScrollChange] needs a multiplier to scroll properly
/// [listScrollMultiplier] Grid and List have different vertical sizes because of top padding
/// So there are two different multipliers for two different states
/// [savedGridOffset] saves the scroll position of the Grid to convert it to the corresponding List position
/// Saves the scroll position of the List to convert it to the corresponding Grid position
/// [cardInternalPosition] is needed to calculate proper in-card offset position
///
/// [duration] Full animation sequence duration
/// [halfOfPrimaryWidth] Half of the screen width
/// [cardHeightWithPadding] The height of the card with top padding
/// [wasChecked] is needed to check only once what kind of card is being viewed currently
/// [wasChecked] is being used in the [unevenScroll] Function
/// [showDebugPrints] shows all the debug info using prints
/// [isAnimatedForward] Additional check for the reverse animation
mixin InitAnimationMixin<T extends StatefulWidget> on State<T> {
  //region [Scroll Variables]
  int gridScrollMultiplier = 0;
  int listScrollMultiplier = 0;
  double savedGridOffset = 0.0;
  double savedListOffset = 0.0;
  double cardInternalPosition = 0.0;
  //endregion

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

  //region [Other Variables]
  Duration duration;
  double halfOfPrimaryWidth;
  double cardHeightWithPadding;
  bool wasChecked = false;
  bool showDebugPrints = false;
  bool isAnimatedForward = true;
  //endregion

  /// [animateTopPadding] animates top padding of the Grid's child widgets
  /// Starts in parallel with [_compensateViewScrollChange]
  /// [animationStatus] is needed to check status in a decent listener so Scroll could work in a proper direction
  void initTopPaddingAnimation() {
    AnimationStatus animationStatus;
    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)

      ..addListener(() {
        if (animationStatus == AnimationStatus.forward) {
          /// Forward animation sequence entry point
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
          /// The end of the reverse animation sequence
          if (showDebugPrints) print('DONE');

          wasChecked = false;
          isAnimatedForward = true;
          initBufferVariables();
        }

      });
  }

  /// [animateUnevenLeftPadding] does not need a [Listener] since it's paralleled with [animateUnevenRightPadding]
  void initUnevenLeftPaddingAnimation() {
    animateUnevenLeftPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(leftUnevenPaddingController);
  }

  /// [animateUnevenRightPadding] animates the right padding of the Grid's uneven child widgets
  void initUnevenRightPaddingAnimation() {
    animateUnevenRightPadding = Tween<double>(begin: 0, end: halfOfPrimaryWidth).animate(rightUnevenPaddingController)
      ..addListener(() => setState(() {}))

      ..addStatusListener((AnimationStatus status) {

        if (status == AnimationStatus.completed && isAnimatedForward) {
          rightEvenPaddingController.forward();
          rightUnevenPaddingController.reverse();

        } else if (status == AnimationStatus.dismissed && !isAnimatedForward) {
          /// Reversed animation entry point
          if (showDebugPrints) print('REVERSE');
          topPaddingController.reverse();
        }

      });
  }

  /// [animateEvenRightPadding] animates right padding of the Grid's even child widgets
  void initEvenRightPaddingAnimation() {
    animateEvenRightPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(rightEvenPaddingController)
      ..addListener(() => setState(() {}))

      ..addStatusListener((AnimationStatus status) {
        /// The end of the forward animation sequence
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

  /// [initBufferVariables] resets the scroll variables
  void initBufferVariables() {
    savedGridOffset = 0.0;
    savedListOffset = 0.0;
    gridScrollMultiplier = 0;
    listScrollMultiplier = 0;
    cardInternalPosition = 0.0;
  }

  /// [_compensateViewScrollChange] compensates size change of the grid/list appearances using the [_jumpTo]
  /// [reversed] divides reverse and forward animation sequences
  /// [savedListOffset] is being calculated from current scroll position in List state
  /// [savedListOffset] and [listScrollMultiplier] are being used in the reverse animation sequence
  /// [savedGridOffset] and [gridScrollMultiplier] are being used in the forward animation sequence
  void _compensateViewScrollChange({bool reversed = false}) {
    if (savedGridOffset == 0.0) savedGridOffset = scrollController.offset;
    if (cardInternalPosition == 0.0) cardInternalPosition = savedGridOffset % cardHeightWithPadding;
    if (gridScrollMultiplier == 0) gridScrollMultiplier = scrollController.offset ~/ cardHeightWithPadding;

    if (reversed) {
      if (savedListOffset == 0.0) {
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

  /// [unevenScroll] checks if widget is uneven and animates it in a different ways corresponding to the card type
  /// The even and uneven cards in the grid are placed in one horizontal line
  /// Thus an uneven card in the list form must be scrolled first before running the main animation sequence
  /// If card is even, when scroll animation goes straight to the main animation sequence
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

  /// [_jumpTo] is the core function of the [_compensateViewScrollChange]
  /// Uses tween value to compensate difference between grid/list appearances
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