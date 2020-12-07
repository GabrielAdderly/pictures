

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


  void initTweens() {
    topPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightEvenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    leftUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);

  }
}