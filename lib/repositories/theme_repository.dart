import 'package:pictures_view/services/storage_service.dart';

class StorageRepository {
  // region [Initialize]
  static const String TAG = '[StorageRepository]';

  StorageRepository._privateConstructor();

  static final StorageRepository _instance = StorageRepository._privateConstructor();

  static StorageRepository get instance => _instance;

  // endregion

  Future<void> addThemeToStorage(String value) => StorageService.instance.addToStorage(StorageKey.theme, value);

  Future<String> getTheme() => StorageService.instance.getElementByKey(StorageKey.theme);

  Future<void> addThemesToStorage(String value) => StorageService.instance.addToStorage(StorageKey.themes, value);

  Future<String> getThemes() => StorageService.instance.getElementByKey(StorageKey.themes);
}