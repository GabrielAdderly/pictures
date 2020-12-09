import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/table/model/cell_builder.dart';

abstract class TableRowIndex {
  const TableRowIndex();

  String get getId;
}

abstract class Cell {
  List<CellBuilder> get row;

  double get fullWidth;

  @protected
  void createListOfElements();
}

abstract class IndexedCell<T> extends Cell with GetFullWith implements TableRowIndex {
  final T element;
  final List<CellBuilder> _row = <CellBuilder>[];

  @mustCallSuper
  IndexedCell(this.element) {
    createListOfElements();
  }

  @override
  List<CellBuilder> get row => _row;
}

mixin GetFullWith on Cell {
  @override
  double get fullWidth {
    double width = 0;
    for (CellBuilder cellBuilder in row) {
      width += cellBuilder.width;
    }
    return width;
  }
}
