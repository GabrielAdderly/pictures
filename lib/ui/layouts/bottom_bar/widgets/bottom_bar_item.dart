import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_item_container.dart';

class BottomBarItem extends ThemeStatelessWidget {
  final double size;
  final IconData iconData;
  final bool isSelected;
  final OnTapFunction onTap;
  final Color selectedColor;

  const BottomBarItem({
    Key key,
    this.iconData,
    this.size = 66.0,
    this.onTap,
    this.isSelected = false,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return BottomBarItemContainer(
      size: size,
      isSelected: isSelected,
      onTap: onTap,
      selectedColor: selectedColor,
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          size: size * 0.4,
          color: isSelected ? selectedColor ?? theme.colors.iconColor : theme.colors.inActiveColor,
        ),
      ),
    );
  }
}
