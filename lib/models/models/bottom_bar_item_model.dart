import 'package:flutter/material.dart';

import 'package:pictures_view/models/models/route_info.dart';

class BottomBarItemModel {
  static double idCounter = 0;

  String _id;
  bool isSelected;
  final IconData iconData;
  final RouteInfo route;

  BottomBarItemModel({
    @required this.iconData,
    @required this.route,
    this.isSelected = false,
  }) {
    _id = idCounter.toString();
    idCounter++;
  }

  String get id => _id;

  void choose() => isSelected = true;

  void discard() => isSelected = false;
}