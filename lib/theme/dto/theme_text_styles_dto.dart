import 'package:json_annotation/json_annotation.dart';

part 'theme_text_styles_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  checked: true,
  explicitToJson: true,
)
class ThemeTextStylesDTO {
  @JsonKey(name: 'titleFontFamily', required: false, nullable: true)
  String titleFontFamily;
  @JsonKey(name: 'textFontFamily', required: false, nullable: true)
  String textFontFamily;
  @JsonKey(name: 'mainTextColor', required: false, nullable: true)
  String mainTextColor;
  @JsonKey(name: 'additionalTextColor', required: false, nullable: true)
  String additionalTextColor;

  ThemeTextStylesDTO({
    this.titleFontFamily,
    this.textFontFamily,
    this.mainTextColor,
    this.additionalTextColor,
  });

  factory ThemeTextStylesDTO.fromJson(Map<String, dynamic> json) => _$ThemeTextStylesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeTextStylesDTOToJson(this);
}