import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

mixin JumpToStateMixin<T extends StatefulWidget> on State<T> {
  Curve _curve = Curves.easeOutQuint;
  ScrollController _controller;

  ScrollController get controller {
    if (_controller == null) initController();

    return _controller;
  }

  @nonVirtual
  void initController() => _controller = ScrollController();

  @nonVirtual
  void disposeController() => _controller.dispose();

  @nonVirtual
  void changeCurve(Curve curve) => _curve = curve;

  @nonVirtual
  void jumpTo(RenderBox box) {
    final Offset position = box.localToGlobal(Offset.zero);
    final double x = position.dx;
    _controller.animateTo(
      x + _controller.offset - 16.0,
      duration: Duration(milliseconds: 500),
      curve: _curve,
    );
  }
}
