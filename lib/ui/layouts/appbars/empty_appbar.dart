import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

class EmptyAppbar extends ThemeStatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  EmptyAppbar()
      : preferredSize = Size.fromHeight(0),
        super(key: const Key('EmptyAppbar'));

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return AnimatedContainer(
      duration: kAVThemeChangeDuration,
      color: theme.colors.accentColor,
      child: const SizedBox(height: 0),
    );
  }
}
