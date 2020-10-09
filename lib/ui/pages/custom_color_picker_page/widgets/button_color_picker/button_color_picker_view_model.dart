import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class ButtonColorPickerViewModel {
  final ChooseColorFunction chooseActiveColor;
  final PopFunction pop;

  ButtonColorPickerViewModel({
    @required this.chooseActiveColor,
    @required this.pop,
  });

  static ButtonColorPickerViewModel fromStore(Store<AppState> store) {
    return ButtonColorPickerViewModel(
      chooseActiveColor: LayoutSelector.getChooseColorFunction(store),
      pop: RouteSelectors.pop(store),
    );
  }
}