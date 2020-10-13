import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/theme/models/custom_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/layout_selector.dart';

class LayoutViewModel {
  final CustomTheme theme;
  final Dictionary dictionary;

  LayoutViewModel({
    @required this.theme,
    @required this.dictionary,
  });

  static LayoutViewModel fromStore(Store<AppState> store) {
    return LayoutViewModel(
      theme: LayoutSelector.getTheme(store),
      dictionary: LayoutSelector.getDictionary(store),
    );
  }

  @override
  bool operator ==(Object other) {
    final bool isIdentical = identical(this, other);

    if (other is LayoutViewModel) {
      return isIdentical || (theme == other.theme && dictionary == other.dictionary);
    }

    return false;
  }

  @override
  int get hashCode => theme.hashCode + dictionary.hashCode;
}
