// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_text_styles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeTextStylesDTO _$ThemeTextStylesDTOFromJson(Map<String, dynamic> json) {
  return $checkedNew('ThemeTextStylesDTO', json, () {
    final val = ThemeTextStylesDTO(
      titleFontFamily:
          $checkedConvert(json, 'titleFontFamily', (v) => v as String),
      textFontFamily:
          $checkedConvert(json, 'textFontFamily', (v) => v as String),
      mainTextColor: $checkedConvert(json, 'mainTextColor', (v) => v as String),
      additionalTextColor:
          $checkedConvert(json, 'additionalTextColor', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$ThemeTextStylesDTOToJson(ThemeTextStylesDTO instance) =>
    <String, dynamic>{
      'titleFontFamily': instance.titleFontFamily,
      'textFontFamily': instance.textFontFamily,
      'mainTextColor': instance.mainTextColor,
      'additionalTextColor': instance.additionalTextColor,
    };
