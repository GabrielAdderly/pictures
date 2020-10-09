import 'package:json_annotation/json_annotation.dart';

part 'theme_colors_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  checked: true,
  explicitToJson: true,
)
class ThemeColorsDTO {
  @JsonKey(name: 'primaryColor', required: false, nullable: true)
  String primaryColor;
  @JsonKey(name: 'accentColor', required: false, nullable: true)
  String accentColor;
  @JsonKey(name: 'backgroundColor', required: false, nullable: true)
  String backgroundColor;
  @JsonKey(name: 'iconColor', required: false, nullable: true)
  String iconColor;
  @JsonKey(name: 'buttonColor', required: false, nullable: true)
  String buttonColor;
  @JsonKey(name: 'inActiveColor', required: false, nullable: true)
  String inActiveColor;

  ThemeColorsDTO({
    this.primaryColor,
    this.accentColor,
    this.backgroundColor,
    this.iconColor,
    this.buttonColor,
    this.inActiveColor,
  });

  factory ThemeColorsDTO.fromJson(Map<String, dynamic> json) => _$ThemeColorsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeColorsDTOToJson(this);
}