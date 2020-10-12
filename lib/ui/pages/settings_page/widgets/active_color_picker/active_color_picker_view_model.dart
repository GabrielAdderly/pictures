import 'package:flutter/foundation.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class ActiveColorPickerViewModel {
  final ChooseColorFunction chooseActiveColor;
  final NavigateToFunction navigateTo;

  ActiveColorPickerViewModel({
    @required this.chooseActiveColor,
    @required this.navigateTo,
  });

  static ActiveColorPickerViewModel fromStore(Store<AppState> store) {
    return ActiveColorPickerViewModel(
      navigateTo: RouteSelectors.navigateTo(store),
      chooseActiveColor: LayoutSelector.getChooseColorFunction(store),
    );
  }
}
