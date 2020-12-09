import 'package:flutter/material.dart';

abstract class CellBuilder<T> {
  final T cellItem;
  final double width;
  final Color color;

  const CellBuilder(
    this.cellItem, {
    @required this.width,
    this.color,
  });

  Widget builder(BuildContext context);
}
