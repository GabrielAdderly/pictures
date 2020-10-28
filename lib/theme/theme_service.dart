import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/adapters/theme_adapter.dart';

import 'package:pictures_view/theme/data/default_themes.dart';
import 'package:pictures_view/theme/models/custom_theme.dart';
import 'package:pictures_view/theme/models/custom_theme_colors.dart';
import 'package:pictures_view/theme/models/custom_theme_text_styles.dart';

class ThemeService {
  ThemeService._privateConstructor() {
    _theme = darkTheme;
  }

  static const String tag = '[CustomTheme]';

  static ThemeService get instance => _instance;

  static final ThemeService _instance = ThemeService._privateConstructor();

  static final List<CustomTheme> _kMainThemes = [darkTheme, lightTheme];

  static final List<Color> mainActiveColors = [
    AppColors.kOrange,
    AppColors.kGreen,
    AppColors.kBlue,
    AppColors.kYellow,
    AppColors.kPurple,
    AppColors.kRed,
  ];

  CustomTheme _theme;

  static List<CustomTheme> mainThemes;

  static CustomTheme get getCurrentTheme => instance._theme;

  static bool isCurrentTheme(CustomTheme theme) => theme == instance._theme;

  static bool isActiveColor(Color color) => color == instance._theme.colors.iconColor;

  Future<void> init() async {
    final CustomTheme theme = await ThemeAdapter.instance.getTheme();
    final List<CustomTheme> themes = await ThemeAdapter.instance.getThemes();
    _theme = theme ?? darkTheme;
    mainThemes = themes ?? _kMainThemes;
    logger.i('Current theme => ${_theme.themeName}');
  }

  Future<void> setNewTheme(CustomTheme thm) async {
    logger.i('$tag => <setNewTheme> => theme => ${thm.themeName}');
    _theme = thm;

    await ThemeAdapter.instance.addThemeToStorage(thm);
  }

  Future<void> setColorWithColorType(Color activeColor, ColorType type) async {
    logger.i('$tag => <setColorWithColorType> => \nactiveColor => ${activeColor.toString()} type => $type}');
    for (CustomTheme theme in mainThemes) {
      _changeColor(theme, type, activeColor);
    }
    _changeColor(_theme, type, activeColor);

    await ThemeAdapter.instance.addThemeToStorage(_theme);
    await ThemeAdapter.instance.addThemesToStorage(mainThemes);
  }

  Future<void> setCustomTheme({@required String themeName, CustomThemeColors colors, CustomThemeTextStyles textStyles}) async {
    logger.i('$tag => <setCustomTheme> => themeName => $themeName}');
    _theme.copyWith(
      themeName: themeName,
      colors: colors,
      textStyles: textStyles,
    );
  }

  void _changeColor(CustomTheme theme, ColorType type, Color color) {
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
