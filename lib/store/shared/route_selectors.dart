import 'package:redux/redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/handler/route_handler.dart';
import 'package:pictures_view/models/models/route_info.dart';

import 'package:pictures_view/store/application/app_state.dart';

class RouteSelectors {
  static NavigateToFunction navigateTo(Store<AppState> store) {
    return (RouteInfo routeInfo) {
      return store.dispatch(RouteHandler.instance.navigateTo(routeInfo));
    };
  }

  static PopFunction pop(Store<AppState> store) {
    return () => store.dispatch(RouteHandler.instance.pop());
  }

  static PopFunction popDialog(Store<AppState> store) {
    return () => store.dispatch(NavigateToAction.pop());
  }
}
