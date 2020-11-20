import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/dictionary/data/en.dart';
import 'package:pictures_view/dictionary/models/supported_language.dart';

class SupportedLocales {
  List<SupportedLanguage> _supportedLocales;

  SupportedLocales._() {
    _supportedLocales = <SupportedLanguage>[
      SupportedLanguage(
        languageCode: kLocaleEn,
        language: en,
      )..choose(),
    ];
  }

  static SupportedLocales instance = SupportedLocales._();

  void changeLocale(String languageCode) {
    _supportedLocales.firstWhere((SupportedLanguage supLang) => supLang.isSelected,orElse: () => null)?.discard();
    _supportedLocales.firstWhere((SupportedLanguage supLang) => supLang.languageCode == languageCode, orElse: () => null)?.choose();
  }

  List<Locale> get getSupportedLocales {
    return _supportedLocales?.map((SupportedLanguage supLang) => supLang.getLocale)?.toList() ?? <SupportedLanguage>[];
  }

  String get getCurrentLocale {
    return _supportedLocales?.firstWhere((SupportedLanguage supLang) => supLang.isSelected)?.languageCode ?? kBaseLocale;
  }

  SupportedLanguage getSupportedLanguage(Locale locale) {
    return _supportedLocales.firstWhere((SupportedLanguage supLang) => supLang.languageCode == locale.languageCode);
  }

}