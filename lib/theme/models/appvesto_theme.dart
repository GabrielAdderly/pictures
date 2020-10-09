import 'package:pictures_view/theme/dto/theme_dto.dart';

import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

class AVTheme {
  String themeName;
  AVColors colors;
  AVTextStyles textStyles;

  AVTheme({
    this.themeName,
    this.colors,
    this.textStyles,
  });

  AVTheme.empty() {
    themeName = '';
    colors = AVColors.empty();
    textStyles = AVTextStyles.empty();
  }

  factory AVTheme.fromDTO(ThemeDTO dto) {
    return AVTheme(
      themeName: dto.themeName,
      colors: AVColors.fromDTO(dto.colors),
      textStyles: AVTextStyles.fromDTO(dto.textStyles),
    );
  }

  ThemeDTO toDTO() {
    return ThemeDTO(
      themeName: themeName,
      colors: colors.toDTO(),
      textStyles: textStyles.toDTO(),
    );
  }

  AVTheme copyWith({
    String themeName,
    AVColors colors,
    AVTextStyles textStyles,
  }) {
    return AVTheme(
      colors: colors ?? this.colors,
      themeName: themeName ?? this.themeName,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  @override
  bool operator ==(Object other) {
    bool isIdentical = identical(this, other);

    if (other is AVTheme) {
      return isIdentical || themeName == other.themeName;
    }

    return false;
  }

  @override
  int get hashCode => themeName.hashCode;
}
