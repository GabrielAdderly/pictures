import 'package:pictures_view/theme/dto/theme_dto.dart';

import 'package:pictures_view/theme/models/custom_theme_colors.dart';
import 'package:pictures_view/theme/models/custom_theme_text_styles.dart';

class CustomTheme {
  String themeName;
  CustomThemeColors colors;
  CustomThemeTextStyles textStyles;

  CustomTheme({
    this.themeName,
    this.colors,
    this.textStyles,
  });

  CustomTheme.empty() {
    themeName = '';
    colors = CustomThemeColors.empty();
    textStyles = CustomThemeTextStyles.empty();
  }

  factory CustomTheme.fromDTO(ThemeDTO dto) {
    return CustomTheme(
      themeName: dto.themeName,
      colors: CustomThemeColors.fromDTO(dto.colors),
      textStyles: CustomThemeTextStyles.fromDTO(dto.textStyles),
    );
  }

  ThemeDTO toDTO() {
    return ThemeDTO(
      themeName: themeName,
      colors: colors.toDTO(),
      textStyles: textStyles.toDTO(),
    );
  }

  CustomTheme copyWith({
    String themeName,
    CustomThemeColors colors,
    CustomThemeTextStyles textStyles,
  }) {
    return CustomTheme(
      colors: colors ?? this.colors,
      themeName: themeName ?? this.themeName,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  @override
  bool operator ==(Object other) {
    final bool isIdentical = identical(this, other);

    if (other is CustomTheme) {
      return isIdentical || themeName == other.themeName;
    }

    return false;
  }

  @override
  int get hashCode => themeName.hashCode;
}
