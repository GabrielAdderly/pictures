import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pictures_view/widgets/table/model/table_data.dart';
import 'package:pictures_view/widgets/table/widgets/cell_block.dart';
import 'package:pictures_view/widgets/table/model/cell_builder.dart';
import 'package:pictures_view/widgets/table/widgets/table_wrapper.dart';
import 'package:pictures_view/widgets/table/model/table_row_element.dart';

class ClockingTable extends StatefulWidget {
  final List<Cell> elements;
  final TableData tableData;

  ClockingTable({
    @required this.elements,
    Key key,
    TableData tableData,
  })  : assert(elements != null, throw ('Elements can\'t be null!')),
        tableData = tableData ?? TableData.general(),
        super(key: key);

  @override
  _ClockingTableState createState() => _ClockingTableState();
}

class _ClockingTableState extends State<ClockingTable> {
  int _selectedIndex = -1;

  void selectIndex(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = -1;
    } else {
      _selectedIndex = index;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TableWrapper(
      elements: widget.elements,
      tableData: widget.tableData,
      builder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            selectIndex(index);
            if (widget.tableData.chosenRowCallback != null && _selectedIndex != -1) widget.tableData.chosenRowCallback(index);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.elements[index].row.map((CellBuilder cellBuilder) {
              return CellBlock(
                color: _selectedIndex == index ? widget.tableData.chosenRowColor : null,
                tableData: widget.tableData,
                cellBuilder: cellBuilder,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
