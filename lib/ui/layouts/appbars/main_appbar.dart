import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

class MainAppBar extends ThemeStatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final double height;
  final String title;
  final AdditionalAppbarWidget additionalAppBarElement;

  MainAppBar({
    @required this.title,
    this.height = 88.0,
    this.additionalAppBarElement = const NonAdditionalStatelessWidget(),
  })  : preferredSize = Size.fromHeight(height + additionalAppBarElement.getHeight),
        assert(title != null, throw ('You forgot filled title!')),
        assert(additionalAppBarElement != null, throw ('additionalAppBarElement is null!')),
        super(key: const Key('MainAppBar'));

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return AnimatedContainer(
      duration: kAVThemeChangeDuration,
      color: theme.colors.accentColor,
      child: SafeArea(
        top: true,
        child: Container(
          height: height + additionalAppBarElement.getHeight,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Text(
                title,
                style: theme.textStyles.titleTextStyle(height: 1.3),
              ),
              Spacer(),
              additionalAppBarElement,
            ],
          ),
        ),
      ),
    );
  }
}
