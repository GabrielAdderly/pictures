import 'package:flutter/material.dart';

typedef ChosenRowCallback = void Function (int);

class TableData {
  final double height;
  final double width;
  final double rowIndent;
  final double columnIndent;
  final Color cellColor;
  final Color chosenRowColor;
  final Alignment cellChildAlignment;
  final ScrollBehavior scrollBehavior;
  final ChosenRowCallback chosenRowCallback;

  const TableData({
    @required this.height,
    @required this.width,
    this.chosenRowCallback,
    this.scrollBehavior,
    double rowIndent = 1.0,
    double columnIndent = 1.0,
    this.cellColor = Colors.white,
    this.chosenRowColor = Colors.redAccent,
    this.cellChildAlignment = Alignment.center,
  })  : rowIndent = rowIndent / 2,
        columnIndent = columnIndent / 2;

  factory TableData.general() {
    return TableData(
      width: 200.0,
      height: 40.0,
    );
  }
}
