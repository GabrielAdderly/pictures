import 'package:flutter/material.dart';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/icons/bottom_bar_icons.dart';

import 'package:pictures_view/models/models/pages.dart';
import 'package:pictures_view/models/models/route_info.dart';
import 'package:pictures_view/models/models/bottom_bar_item_model.dart';

class RouteHandler {
  // region [Initialization]
  static const String TAG = '[RouteHelper]';

  static final List<BottomBarItemModel> initBarItems = [
    BottomBarItemModel(
      route: ROUTE_INFO_FAVORITES_PAGE,
      iconData: BottomBarIcons.favorites,
    ),
    BottomBarItemModel(
      route: ROUTE_INFO_HOME_PAGE,
      iconData: BottomBarIcons.home,
      isSelected: true,
    ),
    BottomBarItemModel(
      route: ROUTE_INFO_SETTINGS_PAGE,
      iconData: BottomBarIcons.settings,
    ),
  ];

  Pages _pages;
  List<BottomBarItemModel> barItems;

  RouteHandler._privateConstructor() {
    _pages = Pages();
    barItems = List.from(initBarItems);
  }

  static final RouteHandler _instance = RouteHandler._privateConstructor();

  static RouteHandler get instance => _instance;

  // endregion

  bool get isNotEmptyPages => !_pages.isPagesEmpty;

  NavigateToAction navigateTo(RouteInfo routeInfo) {
    logger.i('$TAG => navigateTo() => routeName: ${routeInfo.route}');

    if (!_pages.isPagesEmpty && _pages.isLastRoute(routeInfo)) return null;

    _changeBar(routeInfo);

    return _getAction(routeInfo);
  }

  NavigateToAction pop() {
    logger.i('$TAG => pop()');

    _pages.pop();
    _changeBar(_pages.last);

    return NavigateToAction.pop();
  }

  void _changeBar(RouteInfo routeInfo) {
    barItems?.firstWhere((barItem) => barItem.isSelected)?.discard();
    barItems?.firstWhere((barItem) => routeInfo == barItem.route)?.choose();
  }

  NavigateToAction _getAction(RouteInfo routeInfo) {
    logger.i('$TAG => getAction()');

    if (_pages.prevLevel == routeInfo.level) return _replace(routeInfo);

    return _push(routeInfo);
  }

  NavigateToAction _replace(RouteInfo routeInfo) {
    logger.i('$TAG => replace()');

    _pages.pop();
    _pages.push(routeInfo);

    return NavigateToAction.replace(routeInfo.route);
  }

  NavigateToAction _push(RouteInfo routeInfo) {
    logger.i('$TAG => push()');

    _pages.push(routeInfo);

    return NavigateToAction.push(routeInfo.route);
  }
}
