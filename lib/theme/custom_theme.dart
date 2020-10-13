import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pictures_view/adapters/theme_adapter.dart';
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

  static bool isActiveColor(Color color) => color == instance._theme.colors.iconColor;

  static List<AVTheme> _kMainThemes = [darkTheme, lightTheme];

  static List<AVTheme> mainThemes;

  static List<Color> mainActiveColors = [
    AppColors.kOrange,
    AppColors.kGreen,
    AppColors.kBlue,
    AppColors.kYellow,
    AppColors.kPurple,
    AppColors.kRed,
  ];

  AVTheme _theme;

  Future<void> init() async {
    AVTheme theme = await ThemeAdapter.instance.getTheme();
    List<AVTheme> themes = await ThemeAdapter.instance.getThemes();
    _theme = theme ?? darkTheme;
    mainThemes = themes ?? _kMainThemes;
    logger.i('Current theme => ${_theme.themeName}');
  }

  Future<void> setNewTheme(AVTheme thm) async {
    logger.i('$tag => setNewTheme() => theme => ${thm.themeName}');
    _theme = thm;

    await ThemeAdapter.instance.addThemeToStorage(thm);
  }

  Future<void> setColorWithColorType(Color activeColor, ColorType type) async {
    for (AVTheme theme in mainThemes) {
      _changeColor(theme, type, activeColor);
    }
    _changeColor(_theme, type, activeColor);

    await ThemeAdapter.instance.addThemeToStorage(_theme);
    await ThemeAdapter.instance.addThemesToStorage(mainThemes);
  }

  Future<void> setCustomTheme({@required String themeName, AVColors colors, AVTextStyles textStyles}) async {
    logger.i('$tag => setCustomTheme() => themeName => $themeName}');
    _theme.copyWith(
      themeName: themeName,
      colors: colors,
      textStyles: textStyles,
    );
  }

  void _changeColor(AVTheme theme, ColorType type, Color color) {
    switch (type) {
      case ColorType.icon:
        theme.colors.iconColor = color;
        break;
      case ColorType.button:
        theme.colors.buttonColor = color;
        break;
    }
  }

}

enum ColorType {
  icon,
  button,
}
