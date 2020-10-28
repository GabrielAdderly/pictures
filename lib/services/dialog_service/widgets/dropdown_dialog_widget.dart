import 'package:flutter/material.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/services/dialog_service/models/dropdown_dialog.dart';

class ClientDropdown extends StatefulWidget {
  final DropdownDialog dialog;

  ClientDropdown(this.dialog) : super(key: Key('ClientDropdown'));

  @override
  _ClientDropdownState createState() => _ClientDropdownState();
}

class _ClientDropdownState extends State<ClientDropdown> {
  bool isForceClose = true;

  @override
  void dispose() {
    if (widget.dialog.whenSheetDispose != null) {
      widget.dialog.whenSheetDispose(isForceClose);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Container(
            height: 24,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 16.0,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.red,
                      size: 17.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 34.0,
                    ),
                    child: Text(
                      widget.dialog.title ?? 'EMPTY_STRING',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(color: Colors.black26, height: 1.0),
          Container(
            height: 240,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            color: Colors.white,
            child: ListView.builder(
              itemCount: widget.dialog.list.length,
              itemBuilder: (BuildContext context, int index) {
                if (widget.dialog.printedParam == null ||
                    widget.dialog.printedParam.isEmpty ||
                    widget.dialog.list[index][widget.dialog.printedParam] == null ||
                    widget.dialog.list[index][widget.dialog.printedParam].isEmpty ||
                    widget.dialog.list[index][widget.dialog.printedParam] == kSpaceString) {
                  return Container();
                }

                if (widget.dialog.list.length - 1 == index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        isForceClose = false;
                      });
                      widget.dialog.onItemSelected(index);
                    },
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        widget.dialog.list[index][widget.dialog.printedParam],
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          isForceClose = false;
                        });
                        widget.dialog.onItemSelected(index);
                      },
                      child: Container(
                        height: 45.0,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          widget.dialog.list[index][widget.dialog.printedParam],
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(color: Colors.black26, height: 1.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
