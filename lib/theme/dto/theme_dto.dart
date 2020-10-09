import 'package:json_annotation/json_annotation.dart';
import 'package:pictures_view/theme/dto/theme_colors_dto.dart';
import 'package:pictures_view/theme/dto/theme_text_styles_dto.dart';

part 'theme_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  checked: true,
  explicitToJson: true,
)
class ThemeDTO {
  @JsonKey(name: 'themeName', required: false, nullable: true)
  String themeName;
  @JsonKey(name: 'colors', required: false, nullable: true)
  ThemeColorsDTO colors;
  @JsonKey(name: 'textStyles', required: false, nullable: true)
  ThemeTextStylesDTO textStyles;

  ThemeDTO({
    this.themeName,
    this.colors,
    this.textStyles,
  });

  factory ThemeDTO.fromJson(Map<String, dynamic> json) => _$ThemeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeDTOToJson(this);
}