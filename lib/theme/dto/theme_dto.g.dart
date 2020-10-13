// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeDTO _$ThemeDTOFromJson(Map<String, dynamic> json) {
  return $checkedNew('ThemeDTO', json, () {
    final val = ThemeDTO(
      themeName: $checkedConvert(json, 'themeName', (v) => v as String),
      colors: $checkedConvert(
          json,
          'colors',
          (v) => v == null
              ? null
              : ThemeColorsDTO.fromJson(v as Map<String, dynamic>)),
      textStyles: $checkedConvert(
          json,
          'textStyles',
          (v) => v == null
              ? null
              : ThemeTextStylesDTO.fromJson(v as Map<String, dynamic>)),
    );
    return val;
  });
}

Map<String, dynamic> _$ThemeDTOToJson(ThemeDTO instance) => <String, dynamic>{
      'themeName': instance.themeName,
      'colors': instance.colors?.toJson(),
      'textStyles': instance.textStyles?.toJson(),
    };
