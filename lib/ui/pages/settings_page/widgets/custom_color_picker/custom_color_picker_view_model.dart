import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';

class CustomColorPickerViewModel {
  final NavigateToFunction navigateTo;

  CustomColorPickerViewModel({
    @required this.navigateTo,
  });

  static CustomColorPickerViewModel fromStore(Store<AppState> store) {
    return CustomColorPickerViewModel(
      navigateTo: RouteSelectors.navigateTo(store),
    );
  }
}
