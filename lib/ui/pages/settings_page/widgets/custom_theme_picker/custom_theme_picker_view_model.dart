import 'package:flutter/foundation.dart';
import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/store/pages/settings_page_state/settings_page_selector.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/store/application/app_state.dart';

class CustomThemePickerViewModel {
  final ChangeThemeFunction chooseTheme;

  CustomThemePickerViewModel({
    @required this.chooseTheme,
  });

  static CustomThemePickerViewModel fromStore(Store<AppState> store) {
    return CustomThemePickerViewModel(
      chooseTheme: SettingsPageSelector.getChangeThemeFunction(store),
    );
  }
}
