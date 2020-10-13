// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_colors_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeColorsDTO _$ThemeColorsDTOFromJson(Map<String, dynamic> json) {
  return $checkedNew('ThemeColorsDTO', json, () {
    final val = ThemeColorsDTO(
      primaryColor: $checkedConvert(json, 'primaryColor', (v) => v as String),
      accentColor: $checkedConvert(json, 'accentColor', (v) => v as String),
      backgroundColor:
          $checkedConvert(json, 'backgroundColor', (v) => v as String),
      iconColor: $checkedConvert(json, 'iconColor', (v) => v as String),
      buttonColor: $checkedConvert(json, 'buttonColor', (v) => v as String),
      inActiveColor: $checkedConvert(json, 'inActiveColor', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$ThemeColorsDTOToJson(ThemeColorsDTO instance) =>
    <String, dynamic>{
      'primaryColor': instance.primaryColor,
      'accentColor': instance.accentColor,
      'backgroundColor': instance.backgroundColor,
      'iconColor': instance.iconColor,
      'buttonColor': instance.buttonColor,
      'inActiveColor': instance.inActiveColor,
    };
