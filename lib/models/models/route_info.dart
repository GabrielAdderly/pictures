import 'package:flutter/foundation.dart';

import 'package:pictures_view/res/const.dart';

class RouteInfo {
  static const int kFirstLevel = 0;
  static const int kSecondLevel = 1;

  final String route;
  final int level;

  const RouteInfo({
    @required this.route,
    @required this.level,
  });

  factory RouteInfo.empty() {
    return RouteInfo(route: kSpaceString, level: -1);
  }

  bool get isFirstLevel => level == kFirstLevel;

  bool get isSecondLevel => level == kSecondLevel;
}
