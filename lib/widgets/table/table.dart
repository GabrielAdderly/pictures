import 'package:flutter/material.dart';
import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/widgets/clean_behavior.dart';

abstract class IndexedTableElement {
  static int idCounter = 0;

  int _id;

  String get getId => _id.toString();

  IndexedTableElement() {
    _id = ++idCounter;
  }
}

abstract class TableElement<T> extends IndexedTableElement {
  final T element;
  final List<String> row = <String>[];

  @mustCallSuper
  TableElement(this.element) {
    createListOfElements(element);
  }

  @protected
  void createListOfElements(T element);
}

class ClockingTable<T extends TableElement> extends StatelessWidget {
  final List<TableElement> elements;

  ClockingTable({
    @required Key key,
    @required this.elements,
  }) : super(key: key);

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CleanBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: elements.map((TableElement element) {
                      return Row(
                        children: element.row.map((String rowElement) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                            child: Container(
                              width: 160.0,
                              constraints: BoxConstraints(
                                minHeight: 40.0,
                              ),
                              alignment: Alignment.center,
                              color: AppColors.kWhite,
                              child: Text(rowElement),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
