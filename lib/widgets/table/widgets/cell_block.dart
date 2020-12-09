import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/table/model/table_data.dart';
import 'package:pictures_view/widgets/table/model/cell_builder.dart';

class CellBlock extends StatelessWidget {
  final Color color;
  final TableData tableData;
  final CellBuilder cellBuilder;

  const CellBlock({
    @required this.tableData,
    @required this.cellBuilder,
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: tableData.height,
        maxWidth: cellBuilder.width,
      ),
      color: color ?? tableData.cellColor,
      margin: EdgeInsets.symmetric(
        horizontal: tableData.columnIndent,
        vertical: tableData.rowIndent,
      ),
      child: cellBuilder.builder(context),
    );
  }
}
