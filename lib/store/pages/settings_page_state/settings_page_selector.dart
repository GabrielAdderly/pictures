import 'package:flutter/material.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/pages/settings_page_state/actions/change_theme.dart';
import 'package:pictures_view/store/pages/settings_page_state/actions/change_active_color.dart';


class SettingsPageSelector {
  static ChangeThemeFunction getChangeThemeFunction(Store<AppState> store) {
    return (AVTheme theme) => store.dispatch(ChangeTheme(theme));
  }

  static ChooseColorFunction getChooseColorFunction(Store<AppState> store) {
    return (Color color) => store.dispatch(ChangeActiveColor(color: color));
  }
}