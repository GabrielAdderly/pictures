import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/widgets/table/table.dart';
import 'package:pictures_view/widgets/table/dummy/dummy_obj.dart';
import 'package:pictures_view/widgets/table/model/table_data.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';

class FavoritesPage extends PageWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return MainAppBar(title: 'TABLE');
  }

  @override
  Widget buildBody(BuildContext context, CustomTheme theme, Dictionary dictionary) {
    final List<ParrotCell> list = [
      for (int i = 0; i < 100; i++) ParrotCell(Parrot.generalByIndex(i)),
    ];

    return Container(
      color: theme.colors.accentColor,
      child: ClockingTable(
        key: UniqueKey(),
        elements: list,
        tableData: TableData(
          width: 400.0,
          height: 50.0,
          chosenRowCallback: (int index) {
            showDialog(
              context: context,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 200.0,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Spacer(),
                          Text('Selected index: $index'),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: Navigator.of(context).pop,
                            child: Container(
                              height: 50.0,
                              color: Colors.red,
                              margin: EdgeInsets.symmetric(horizontal: 40.0),
                              alignment: Alignment.center,
                              child: Text('Close'),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
