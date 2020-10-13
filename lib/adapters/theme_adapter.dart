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
  Future<void> addThemeToStorage(CustomTheme theme) async {
    String value;

    final ThemeDTO themeDTO = theme.toDTO();

    final Map<String, dynamic> map = themeDTO.toJson();

    value = json.encode(map);

    await StorageRepository.instance.addThemeToStorage(value);
  }

  Future<CustomTheme> getTheme() async {
    final String fromStorage = await StorageRepository.instance.getTheme();

    if (fromStorage == null) return null;

    final Map<String, dynamic> map = json.decode(fromStorage);

    final ThemeDTO themeDTO = ThemeDTO.fromJson(map);

    return CustomTheme.fromDTO(themeDTO);
  }

  Future<void> addThemesToStorage(List<CustomTheme> themes) async {
    String value;

    final List<ThemeDTO> themeDTO = themes.map((CustomTheme theme) => theme.toDTO()).toList();

    final Map<String, dynamic> map = {
      DATA: themeDTO.map((ThemeDTO dto) => dto.toJson()).toList(),
    };

    value = json.encode(map);

    await StorageRepository.instance.addThemesToStorage(value);
  }

  Future<List<CustomTheme>> getThemes() async {
    final String fromStorage = await StorageRepository.instance.getThemes();

    if (fromStorage == null) return null;

    final Map<String, dynamic> map = json.decode(fromStorage);

    final List<ThemeDTO> themesDTO = [];

    map[DATA].forEach((el) {
      themesDTO.add(ThemeDTO.fromJson(el));
    });

    return themesDTO.map((ThemeDTO dto) => CustomTheme.fromDTO(dto)).toList();
  }
}