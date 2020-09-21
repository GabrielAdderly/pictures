import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/dictionary/flutter_delegate.dart';

class FlutterDictionary {
  static const String tag = '[FlutterDictionary]';

  FlutterDictionary._privateConstructor({this.locale});

  static final FlutterDictionary _instance = FlutterDictionary._privateConstructor();

  static FlutterDictionary get instance => _instance;

  final Locale locale;
  Language language;

  FlutterDictionary(this.locale) {
    if (locale != null) setNewLanguage(locale.languageCode);
  }

  void setNewLanguage(String languageCode) {
    logger.i('$tag => setNewLanguage() => locale => $languageCode');
    FlutterDictionaryDelegate.changeLocaleWithLanguageCode(languageCode);
    language = FlutterDictionaryDelegate.getLanguageByLanguageCode(languageCode);
  }

  void setNewLanguageAndSave(String languageCode) {
    logger.i('$tag => setNewLanguageAndSave() => locale => $languageCode');
    language = FlutterDictionaryDelegate.getLanguageByLanguageCode(languageCode);
  }

  static const List<String> _rtlLanguages = <String>[
    LOCALE_HE,
    LOCALE_PS,
    LOCALE_UR,
    LOCALE_AR,
    LOCALE_FA,
  ];

  bool get isRTL {
    return _rtlLanguages.contains(FlutterDictionaryDelegate.getCurrentLocale);
  }
}