import 'package:flutter/foundation.dart';

class RouteInfo {
  static const int FIRST_LEVEL = 0;
  static const int SECOND_LEVEL = 1;

  final String route;
  final int level;

  const RouteInfo({
    @required this.route,
    @required this.level,
  });

  factory RouteInfo.empty() {
    return RouteInfo(route: ' ', level: -1);
  }

  bool get isFirstLevel => level == FIRST_LEVEL;

  bool get isSecondLevel => level == SECOND_LEVEL;
}
