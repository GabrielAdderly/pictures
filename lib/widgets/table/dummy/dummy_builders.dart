import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/table/model/cell_builder.dart';

class TextBuilder<T> extends CellBuilder<T> {
  TextBuilder(T cellItem, double width) : super(cellItem, width: width);

  @override
  Widget builder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text('$cellItem'),
    );
  }
}

class GeneralTextBuilder extends CellBuilder<String> {
  GeneralTextBuilder(String cellItem, double width) : super(cellItem, width: width);

  @override
  Widget builder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text('$cellItem'),
    );
  }
}

class DateBuilder extends CellBuilder<DateTime> {
  DateBuilder(DateTime cellItem, double width) : super(cellItem, width: width);

  @override
  Widget builder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        'date: $cellItem',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class IntBuilder extends CellBuilder<int> {
  IntBuilder(int cellItem, double width) : super(cellItem, width: width);

  @override
  Widget builder(BuildContext context) {
    return ChangeValueWidget(
      initialValue: cellItem,
      callback: (int value) {},
    );
  }
}

class ChangeValueWidget extends StatefulWidget {
  final int initialValue;
  final void Function(int) callback;

  const ChangeValueWidget({
    @required this.initialValue,
    @required this.callback,
    Key key,
  }) : super(key: key);

  @override
  _ChangeValueWidgetState createState() => _ChangeValueWidgetState();
}

class _ChangeValueWidgetState extends State<ChangeValueWidget> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void increment() => setState(() => value++);

  void decrement() => setState(() => value--);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              decrement();
              widget.callback(value);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text('$value'),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              increment();
              widget.callback(value);
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}
