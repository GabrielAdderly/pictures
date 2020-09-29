import 'package:flutter/material.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/theme/custom_theme.dart';

import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_item_container.dart';

class BottomBarItem extends StatelessWidget {
  final double size;
  final IconData iconData;
  final bool isSelected;
  final OnTapFunction onTap;

  const BottomBarItem({
    Key key,
    this.iconData,
    this.size = 66.0,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarItemContainer(
      size: size,
      isSelected: isSelected,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          size: size * 0.4,
          color: isSelected
              ? CustomTheme.colors.activeColor
              : CustomTheme.colors.inActiveColor,
        ),
      ),
    );
  }
}
