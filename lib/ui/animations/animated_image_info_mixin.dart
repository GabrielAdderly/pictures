import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';

import 'package:pictures_view/res/const.dart';

mixin AnimatedImageInfoMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  bool isOpened = false;

  AnimationController _animationController;

  Animation<double> _paddingAnimation;
  Animation<double> _imageSizeAnimation;
  Animation<double> _containerSizeAnimation;

  double get getAnimatedPadding => _paddingAnimation?.value ?? 0;

  double get getAnimatedImageSize => _imageSizeAnimation?.value ?? 0;

  double get getAnimatedContainerSize => _containerSizeAnimation?.value ?? 0;

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: kBaseChangeDuration,
    )..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback(_bindingsInitAnimation);
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @protected
  @nonVirtual
  void _bindingsInitAnimation(Duration timeStamp) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double minPadding = maxHeight * 0.25;
    final double maxPadding = maxHeight * 0.7;

    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _paddingAnimation = Tween<double>(begin: maxPadding, end: minPadding).animate(curvedAnimation);
    _containerSizeAnimation = Tween<double>(begin: minPadding, end: maxPadding).animate(curvedAnimation);
    _imageSizeAnimation = Tween<double>(begin: maxPadding + 50.0, end: minPadding + 50.0).animate(curvedAnimation);
    setState(() {});
  }

  @protected
  @mustCallSuper
  void changePosition() {
    isOpened = !isOpened;
    if (isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
