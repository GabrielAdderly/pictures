import 'dart:ui';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

import 'package:pictures_view/theme/models/custom_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/actions/layout_actions.dart';

class LayoutSelector {

  static CustomTheme getTheme (Store<AppState> store) {
    return store.state.layoutState.theme;
  }

  static Dictionary getDictionary (Store<AppState> store) {
    return store.state.layoutState.dictionary;
  }

  static ChangeThemeFunction getThemeFunction(Store<AppState> store) {
    return (CustomTheme theme) => store.dispatch(GetThemeAction(theme: theme));
  }

  static ChangeThemeFunction getChangeThemeFunction(Store<AppState> store) {
    return (CustomTheme theme) => store.dispatch(ChangeThemeAction(theme: theme));
  }

  static ChooseColorFunction getChooseColorFunction(Store<AppState> store) {
    return (Color color, ColorType colorType) => store.dispatch(ChangeActiveColorAction(color: color, colorType: colorType));
  }

  static void Function() getDictionaryFunction(Store<AppState> store) {
    return () => store.dispatch(GetDictionaryAction(dictionary: FlutterDictionary.instance.dictionary));
  }

  static void Function() getChangeDictionaryFunction(Store<AppState> store) {
    return () => store.dispatch(ChangeDictionaryAction(dictionary: null));
  }
}