import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/store/application/app_state.dart';

class ThemeSettingsViewModel {
  final Function chooseTheme;

  ThemeSettingsViewModel({
    @required this.chooseTheme,
  });

  static ThemeSettingsViewModel fromStore(Store<AppState> store) {
    return ThemeSettingsViewModel(
      chooseTheme: () {},
    );
  }
}
