import 'package:flutter/material.dart';
import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/res/app_styles/app_shadows.dart';

import 'package:pictures_view/theme/custom_theme.dart';

class BottomBarItemContainer extends ThemeStatelessWidget {
  final double size;
  final Widget child;
  final bool isSelected;
  final OnTapFunction onTap;
  final Color selectedColor;

  const BottomBarItemContainer({
    @required this.size,
    @required this.child,
    this.onTap,
    this.selectedColor,
    Key key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.accentColor : theme.colors.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: isSelected ? selectedColor ?? theme.colors.iconColor : theme.colors.primaryColor,
          ),
          boxShadow: isSelected ? AppShadows.bottomBarItemShadow(selectedColor ?? theme.colors.iconColor) : [],
        ),
        child: child,
      ),
    );
  }
}
