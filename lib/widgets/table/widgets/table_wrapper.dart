import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/table/model/table_data.dart';
import 'package:pictures_view/widgets/table/model/table_row_element.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class TableWrapper extends StatelessWidget {
  final List<Cell> elements;
  final TableData tableData;
  final IndexedWidgetBuilder builder;

  const TableWrapper({
    @required this.elements,
    @required this.tableData,
    @required this.builder,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: tableData.scrollBehavior ?? CleanBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: elements.length,
            itemBuilder: builder,
          ),
        ),
      ),
    );
  }

  double get tableWidth {
    final Cell cell = elements.first;

    if (cell == null) return 0;

    return (cell.row.length * tableData.columnIndent * 2) + cell.fullWidth;
  }
}
