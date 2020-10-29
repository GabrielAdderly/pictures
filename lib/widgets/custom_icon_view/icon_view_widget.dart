import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/widgets/custom_icon_view/custom_icon_view_paint.dart';

class IconViewWidget extends StatefulWidget {
  final double size;
  final Color color;
  final Color bgColor;
  final Color strokeColor;
  final Duration duration;
  final Duration reverseDuration;
  final double strokeWidth;
  final BorderRadius borderRadius;
  final void Function() onTap;

  IconViewWidget({
    @required this.onTap,
    this.size = 25.0,
    this.color,
    this.bgColor,
    this.strokeColor,
    this.strokeWidth,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 600),
    this.reverseDuration = const Duration(milliseconds: 800),
    Key key,
  })  : assert(duration != null && onTap != null),
        super(key: key);

  @override
  _IconViewWidgetState createState() => _IconViewWidgetState();
}

class _IconViewWidgetState extends State<IconViewWidget> with TickerProviderStateMixin {
  bool isOpened = false;
  AnimationController reverseController;
  AnimationController cubeController;
  AnimationController rectController;

  @override
  void initState() {
    reverseController = AnimationController(duration: widget.duration, vsync: this, value: 0.0);
    cubeController = AnimationController(duration: widget.duration, vsync: this, value: 0.0);
    rectController = AnimationController(duration: widget.reverseDuration, vsync: this, value: 0.0);

    reverseController.addListener(() => setState(() {}));
    cubeController.addListener(_cubeListener);
    rectController.addListener(_rectListener);
    super.initState();
  }

  @override
  void dispose() {
    reverseController.removeListener(() => setState(() {}));
    cubeController.removeListener(_cubeListener);
    rectController.removeListener(_rectListener);

    reverseController.dispose();
    cubeController.dispose();
    rectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kTransparent,
      child: Ink(
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
        ),
        child: InkWell(
          highlightColor: AppColors.kTransparent,
          splashColor: widget.strokeColor.withOpacity(0.2),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
          onTap: _buttonTap,
          child: Container(
            width: widget.size,
            height: widget.size,
            // color: AppColors.kTransparent,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.kTransparent,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
            ),
            child: Transform.rotate(
              angle: -(pi / (2 / (1 - reverseController.value))),
              child: SizedBox(
                width: widget.size * 0.72,
                height: widget.size * 0.72,
                child: CustomPaint(
                  foregroundPainter: CustomIconViewPaint(
                    strokeWidth: widget.strokeWidth,
                    color: widget.color,
                    strokeColor: widget.strokeColor,
                    widgetSize: widget.size * 0.72,
                    firstAnimationValue: cubeController.value,
                    secondAnimationValue: rectController.value,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _buttonTap() {
    widget.onTap();
    isOpened = !isOpened;
    if (reverseController.value == 0) {
      reverseController.forward();
      cubeController.forward();
    } else {
      rectController.reverse();
    }
  }

  void _cubeListener() {
    if (cubeController.value == 1) {
      rectController.forward();
    }
    setState(() {});
  }

  void _rectListener() {
    if (rectController.value == 0) {
      reverseController.reverse();
      cubeController.reverse();
    }
    setState(() {});
  }
}
