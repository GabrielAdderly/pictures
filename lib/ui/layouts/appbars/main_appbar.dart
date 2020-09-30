import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/ui/widgets/builder_widgets/theme_stateless_widget.dart';

class MainAppBar extends ThemeStatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final double height;
  final String title;

  MainAppBar({
    @required this.title,
    this.height = 88.0,
  })  : preferredSize = Size.fromHeight(height),
        assert(title != null, throw ('You forgot filled title!')),
        super(key: const Key('MainAppBar'));

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return AnimatedContainer(
      duration: kAVThemeChangeDuration,
      color: theme.colors.accentColor,
      child: SafeArea(
        top: true,
        child: Container(
          height: height,
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: theme.textStyles.titleTextStyle(height: 1.3),
          ),
        ),
      ),
    );
  }
}
