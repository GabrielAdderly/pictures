import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';


class BottomBarViewModel {
  final NavigateToFunction navigateTo;

  BottomBarViewModel({@required this.navigateTo,});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    return BottomBarViewModel(
      navigateTo: RouteSelectors.navigateTo(store),
    );
  }
}