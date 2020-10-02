import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_edge_insets.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

class AVTheme {
  final String themeName;
  AVColors colors;
  AVTextStyles textStyles;
  AVEdgeInsets edgeInsets;

  AVTheme({
    this.themeName,
    this.colors,
    this.textStyles,
    this.edgeInsets,
  });

  AVTheme copyWith({
    String themeName,
    AVColors colors,
    AVTextStyles textStyles,
    AVEdgeInsets edgeInsets,
  }) {
    return AVTheme(
      colors: colors ?? this.colors,
      themeName: themeName ?? this.themeName,
      textStyles: textStyles ?? this.textStyles,
      edgeInsets: textStyles ?? this.edgeInsets,
    );
  }
}