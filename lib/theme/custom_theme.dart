import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/theme/data/default_theme.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

class CustomTheme {

  CustomTheme._privateConstructor() {
    _theme = darkTheme;
  }

  static const String tag = '[CustomTheme]';

  static final CustomTheme _instance = CustomTheme._privateConstructor();

  static CustomTheme get instance => _instance;

  static AVTheme get getCurrentTheme => instance._theme;

  static bool isCurrentTheme(AVTheme theme) => theme == instance._theme;

  static bool isActiveColor(Color color) => color == instance._theme.colors.activeColor;

  static List<AVTheme> mainThemes = [darkTheme, lightTheme];

  static List<Color> mainActiveColors = [
    AppColors.kOrange,
    AppColors.kGreen,
    AppColors.kBlue,
    AppColors.kYellow,
  ];

  AVTheme _theme;

  Never setNewTheme(AVTheme thm) {
    logger.i('$tag => setNewTheme() => theme => ${thm.themeName}');
    _theme = thm;
  }

  Never setActiveColor(Color activeColor) {
    for(AVTheme theme in mainThemes) {
      theme.colors.activeColor = activeColor;
    }
    _theme.colors.activeColor = activeColor;
  }

  Never setCustomTheme({@required String themeName, AVColors colors, AVTextStyles textStyles}) {
    logger.i('$tag => setCustomTheme() => themeName => $themeName}');
    _theme.copyWith(
      themeName: themeName,
      colors: colors,
      textStyles: textStyles,
    );
  }
}
