import 'package:flutter/material.dart';
import 'package:pictures_view/handler/route_handler.dart';
import 'package:pictures_view/models/models/bottom_bar_item_model.dart';
import 'package:pictures_view/models/models/route_info.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_item.dart';

enum BottomBarType {
  general,
  example,
}

class BottomBarBuilder {
  // ignore: missing_return
  static Widget build(
    BottomBarType type, {
    void Function(RouteInfo) navigateFunc,
    Color selectedColor,
  }) {
    switch (type) {
      case BottomBarType.general:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: RouteHandler.instance.barItems.map((BottomBarItemModel bottomBarItemModel) {
            return BottomBarItem(
              onTap: () => navigateFunc(bottomBarItemModel.route),
              iconData: bottomBarItemModel.iconData,
              isSelected: bottomBarItemModel.isSelected,
            );
          }).toList(),
        );
      case BottomBarType.example:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: RouteHandler.instance.barItems.map((BottomBarItemModel bottomBarItemModel) {
            return BottomBarItem(
              onTap: () {},
              iconData: bottomBarItemModel.iconData,
              isSelected: bottomBarItemModel.isSelected,
              selectedColor: selectedColor,
            );
          }).toList(),
        );
    }
  }
}
