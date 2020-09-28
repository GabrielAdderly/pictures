import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/theme/data/default_theme.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

import 'models/appvesto_theme.dart';

class CustomTheme {
  static const String tag = '[CustomTheme]';

  CustomTheme._privateConstructor();

  static final CustomTheme _instance = CustomTheme._privateConstructor();

  static CustomTheme get instance => _instance;

  AVTheme theme;

  Never init(AVTheme initialTheme) {
    theme = initialTheme ?? darkTheme;
  }

  Never setNewTheme(AVTheme thm) {
    logger.i('$tag => setNewTheme() => theme => ${thm.themeName}');
    theme = thm;
  }

  Never setCustomTheme({@required String themeName, AVColors colors, AVTextStyles textStyles}) {
    logger.i('$tag => setCustomTheme() => themeName => $themeName}');
    theme.copyWith(
      themeName: themeName,
      colors: colors,
      textStyles: textStyles,
    );
  }
}