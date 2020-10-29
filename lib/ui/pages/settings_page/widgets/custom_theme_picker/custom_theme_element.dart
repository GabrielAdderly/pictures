import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

class CustomThemeElement extends ThemeStatelessWidget {
  final CustomTheme customTheme;

  const CustomThemeElement({
    @required this.customTheme,
    Key key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: customTheme.colors.accentColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: ThemeService.isCurrentTheme(customTheme) ? 1.0 : 0.0,
          color: theme.colors.inActiveColor,
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 50.0,
        maxWidth: 110.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Container(color: customTheme.colors.primaryColor)),
            const SizedBox(width: 16.0),
            Expanded(child: Container(color: customTheme.colors.primaryColor)),
          ],
        ),
      ),
    );
  }
}
