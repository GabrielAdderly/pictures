import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/utils/change_status_bar.dart';

class EmptyAppbar extends ThemeStatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  EmptyAppbar()
      : preferredSize = Size.fromHeight(0),
        super(key: const Key('EmptyAppbar'));

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    changeStatusBarTheme(theme.themeName);
    return SafeArea(
      child: AnimatedContainer(
        duration: kAVThemeChangeDuration,
        color: theme.colors.accentColor,
        child: const SizedBox(height: 0),
      ),
    );
  }
}
