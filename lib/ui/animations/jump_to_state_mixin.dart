import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

mixin JumpToStateMixin<T extends StatefulWidget> on State<T> {
  Curve _curve = Curves.easeOutQuint;
  ScrollController controller = ScrollController();

  @nonVirtual
  void initController() => controller = ScrollController();

  @nonVirtual
  void disposeController() => controller.dispose();

  @nonVirtual
  void changeCurve(Curve curve) => _curve = curve;

  @nonVirtual
  void jumpTo(RenderBox box) {
    final Offset position = box.localToGlobal(Offset.zero);
    final double x = position.dx;
    controller.animateTo(
      x + controller.offset - 16.0,
      duration: Duration(milliseconds: 500),
      curve: _curve,
    );
  }
}