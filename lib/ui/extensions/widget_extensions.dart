import 'package:flutter/material.dart';

extension Ratio on Widget {
  Widget aspectRatio(double aspectRation) {
    return AspectRatio(
      aspectRatio: aspectRation,
      child: this,
    );
  }
}

extension Taps on Widget {
  Widget onTap(Function onTap) {
    return InkWell(
      onTap: onTap,
      child: this,

      focusColor: const Color(0x00000000),
      hoverColor: const Color(0x00000000),
      highlightColor: const Color(0x00000000),
      splashColor: const Color(0x00000000),
    );
  }
}