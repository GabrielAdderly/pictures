

import 'package:flutter/material.dart';

mixin InitAnimationMixin {
  Animation animateTopPadding;
  Animation animateEvenRightPadding;
  Animation animateUnevenLeftPadding;
  Animation animateUnevenRightPadding;
  AnimationController topPaddingController;
  AnimationController rightEvenPaddingController;
  AnimationController leftUnevenPaddingController;
  AnimationController rightUnevenPaddingController;

  bool _isAnimatedForward = true;
  bool wasChecked = false;
  double halfOfPrimaryWidth;

  void updatePage() {}


  void initTween() {


  }

  void _compensateViewScrollChange() {}

  void initTopPaddingAnimation() {
    AnimationStatus animationStatus;
    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)
      ..addListener(() {
        if (animationStatus == null) _compensateViewScrollChange();
        if (animationStatus == AnimationStatus.forward) {
          print('FORWARD');
          _compensateViewScrollChange();
        }
        if (animationStatus == AnimationStatus.reverse && !_isAnimatedForward) {
          _compensateViewScrollChange(reversed: true);
        }
        updatePage();
      })
      ..addStatusListener((AnimationStatus status) {
        animationStatus = status;
        if (status == AnimationStatus.completed) {
          leftUnevenPaddingController.forward();
          rightUnevenPaddingController.forward();
        } else if (status == AnimationStatus.dismissed) {
          print('DONE');
          wasChecked = false;
          _isAnimatedForward = true;
          _initBufferVariables();
        }
      });
  }
}