import 'package:flutter/foundation.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/theme/data/default_theme.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

class CustomTheme {
  static const String tag = '[CustomTheme]';

  CustomTheme._privateConstructor() {
    _theme = darkTheme;
  }

  static final CustomTheme _instance = CustomTheme._privateConstructor();

  static CustomTheme get instance => _instance;

  AVTheme _theme;

  Never setNewTheme(AVTheme thm) {
    logger.i('$tag => setNewTheme() => theme => ${thm.themeName}');
    _theme = thm;
  }

  Never setCustomTheme({@required String themeName, AVColors colors, AVTextStyles textStyles}) {
    logger.i('$tag => setCustomTheme() => themeName => $themeName}');
    _theme.copyWith(
      themeName: themeName,
      colors: colors,
      textStyles: textStyles,
    );
  }

  static bool isCurrentTheme(AVTheme theme) {
    return theme == instance._theme;
  }

  static AVTheme get getCurrentTheme => instance._theme;

  static AVColors get colors => instance._theme.colors;

  static AVTextStyles get textStyles => instance._theme.textStyles;

}