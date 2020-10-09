import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class ActiveColorPickerViewModel {
  final ChooseColorFunction chooseActiveColor;

  ActiveColorPickerViewModel({
    @required this.chooseActiveColor,
  });

  static ActiveColorPickerViewModel fromStore(Store<AppState> store) {
    return ActiveColorPickerViewModel(
      chooseActiveColor: LayoutSelector.getChooseColorFunction(store),
    );
  }
}
