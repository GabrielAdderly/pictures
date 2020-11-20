import 'package:flutter/material.dart';
import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/theme/models/custom_theme_colors.dart';
import 'package:pictures_view/ui/layouts/appbars/empty_appbar.dart';
import 'package:pictures_view/widgets/table/table.dart';

class FavoritesPage extends PageWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return EmptyAppbar();
  }

  @override
  Widget buildBody(BuildContext context, CustomTheme theme, Dictionary dictionary) {

    final CustomThemeColorsTableElement colorsTableElement = CustomThemeColorsTableElement(theme.colors);

    final List<TableElement> list = [for(int i = 0; i < 100; i++)colorsTableElement];

    print('id => ${list.first.getId}');

    return Container(
      color: theme.colors.accentColor,
      padding: EdgeInsets.only(top: 50.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Center(
        child: ClockingTable(
          key: UniqueKey(),
          elements: list,
        ),
      ),
    );
  }
}

class CustomThemeColorsTableElement extends TableElement<CustomThemeColors> {
  CustomThemeColorsTableElement(CustomThemeColors element) : super(element);

  @override
  void createListOfElements(CustomThemeColors element) {
    row.add(element.iconColor.toString());
    row.add(element.accentColor.toString());
    row.add(element.primaryColor.toString());
    row.add(element.inActiveColor.toString());
  }

}
