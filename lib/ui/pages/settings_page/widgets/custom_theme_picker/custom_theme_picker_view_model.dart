import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class CustomThemePickerViewModel {
  final ChangeThemeFunction chooseTheme;

  CustomThemePickerViewModel({
    @required this.chooseTheme,
  });

  static CustomThemePickerViewModel fromStore(Store<AppState> store) {
    return CustomThemePickerViewModel(
      chooseTheme: LayoutSelector.getChangeThemeFunction(store),
    );
  }
}
