import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class IconColorPickerViewModel {
  final ChooseColorFunction chooseActiveColor;
  final PopFunction pop;

  IconColorPickerViewModel({
    @required this.chooseActiveColor,
    @required this.pop,
  });

  static IconColorPickerViewModel fromStore(Store<AppState> store) {
    return IconColorPickerViewModel(
      chooseActiveColor: LayoutSelector.getChooseColorFunction(store),
      pop: RouteSelectors.pop(store),
    );
  }
}