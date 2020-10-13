import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/theme/models/custom_theme.dart';

import 'package:pictures_view/store/shared/reducer.dart';
import 'package:pictures_view/store/shared/layouts/actions/layout_actions.dart';

class LayoutState {
  final CustomTheme theme;
  final Dictionary dictionary;

  LayoutState({
    @required this.theme,
    @required this.dictionary,
  });

  factory LayoutState.initial() {
    return LayoutState(
      theme: CustomTheme.empty(),
      dictionary: Dictionary.empty(),
    );
  }

  LayoutState copyWith({
    CustomTheme theme,
    Dictionary dictionary,
  }) {
    return LayoutState(
      theme: theme ?? this.theme,
      dictionary: dictionary ?? this.dictionary,
    );
  }

  LayoutState reducer(dynamic action) {
    return Reducer<LayoutState>(
      actions: HashMap.from({
        GetThemeAction: (dynamic action) => _changeTheme(action as GetThemeAction),
        GetDictionaryAction: (dynamic action) => _changeDictionary(action as GetDictionaryAction),
      }),
    ).updateState(action, this);
  }

  LayoutState _changeTheme(GetThemeAction action) {
    return copyWith(
      theme: action.theme,
    );
  }

  LayoutState _changeDictionary(GetDictionaryAction action) {
    return copyWith(
      dictionary: action.dictionary,
    );
  }
}
