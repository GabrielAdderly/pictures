import 'package:pictures_view/models/models/route_info.dart';

class Pages {
  List<RouteInfo> _pages;

  Pages() {
    _pages = [];
  }

  //region [Getters]
  bool get isPagesEmpty => _pages == null || _pages.isEmpty;

  int get prevLevel {
    if (_pages.isEmpty)return -1;

    return  _pages.last.level;
  }

  RouteInfo get last => _pages.last ?? RouteInfo.empty();

  bool isLastRoute(RouteInfo routeInfo) {
    return routeInfo.route == _pages.last.route;
  }
  //endregion

  void push(RouteInfo page) => _pages.add(page);

  void pop() => _pages.removeLast();

  void stash(RouteInfo routeInfo) {

    if (_pages.isNotEmpty && _pages.length == 1) return;

    _pages.removeWhere((RouteInfo element) => element.route != routeInfo.route);

    if (_pages.isEmpty) push(routeInfo);
  }
}