import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pictures_view/res/const.dart';

enum StorageKey {
  theme,
  themes,
}

class StorageService {
  // region [Initialize]
  static const String TAG = '[StorageService]';

  static StorageService get instance => _instance;

  static final Map _storageKeysMap = <StorageKey, String>{
    StorageKey.theme: 'theme',
    StorageKey.themes: 'themes',
  };

  FlutterSecureStorage storage;

  StorageService._privateConstructor() {
    storage = FlutterSecureStorage();
  }

  static final StorageService _instance = StorageService._privateConstructor();

  // endregion

  Future<void> addToStorage(StorageKey key, String value) async {
    logger.i('$TAG => addToStorage() => key = $key => save: $value');
    try {
      await storage.write(key: _storageKeysMap[key], value: value);
      logger.i('$value is saved to storage!');
    } catch (exception) {
      logger.e('Failed to write text $value');
    }
  }

  Future<String> getElementByKey(StorageKey key) async {
    final String text = await storage.read(key: _storageKeysMap[key]);

    logger.i('$TAG => getElementByKey() => key = $key => return $text');
    return text;
  }
}
