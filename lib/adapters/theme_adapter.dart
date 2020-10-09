import 'dart:convert';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/repositories/theme_repository.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/theme/dto/theme_dto.dart';

class ThemeAdapter {
  // region [Initialize]
  static const String TAG = '[ThemeAdapter]';

  ThemeAdapter._privateConstructor();

  static final ThemeAdapter _instance = ThemeAdapter._privateConstructor();

  static ThemeAdapter get instance => _instance;

  // endregion
  Future<void> addThemeToStorage(AVTheme theme) async {
    String value;

    ThemeDTO themeDTO = theme.toDTO();

    Map<String, dynamic> map = themeDTO.toJson();

    value = json.encode(map);

    await StorageRepository.instance.addThemeToStorage(value);
  }

  Future<AVTheme> getTheme() async {
    String fromStorage = await StorageRepository.instance.getTheme();

    if (fromStorage == null) return null;

    Map<String, dynamic> map = json.decode(fromStorage);

    ThemeDTO themeDTO = ThemeDTO.fromJson(map);

    return AVTheme.fromDTO(themeDTO);
  }

  Future<void> addThemesToStorage(List<AVTheme> themes) async {
    String value;

    List<ThemeDTO> themeDTO = themes.map((AVTheme theme) => theme.toDTO()).toList();

    Map<String, dynamic> map = {
      DATA: themeDTO.map((ThemeDTO dto) => dto.toJson()).toList(),
    };

    value = json.encode(map);

    await StorageRepository.instance.addThemesToStorage(value);
  }

  Future<List<AVTheme>> getThemes() async {
    String fromStorage = await StorageRepository.instance.getThemes();

    if (fromStorage == null) return null;

    Map<String, dynamic> map = json.decode(fromStorage);

    List<ThemeDTO> themesDTO = [];

    map[DATA].forEach((el) {
      themesDTO.add(ThemeDTO.fromJson(el));
    });

    return themesDTO.map((ThemeDTO dto) => AVTheme.fromDTO(dto)).toList();
  }
}