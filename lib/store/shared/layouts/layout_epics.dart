import 'package:rxdart/rxdart.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/actions/layout_actions.dart';

class LayoutEpics {
  static final indexEpic = combineEpics<AppState>([
    setThemeEpic,
    setDictionaryEpic,
    changeActiveColorEpic,
  ]);

  static Stream<dynamic> changeActiveColorEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ChangeActiveColorAction>().switchMap((action) async* {
      await CustomTheme.instance.setColorWithColorType(action.color, action.colorType);
      yield* Stream.value(GetThemeAction(theme: CustomTheme.getCurrentTheme));
    });
  }

  static Stream<dynamic> setThemeEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ChangeThemeAction>().switchMap((ChangeThemeAction action) async* {
      await CustomTheme.instance.setNewTheme(action.theme);
      yield* Stream.value(GetThemeAction(theme: action.theme));
    });
  }

  static Stream<dynamic> setDictionaryEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ChangeDictionaryAction>().switchMap((ChangeDictionaryAction action) {
      FlutterDictionary.instance.setNewDictionary(action.dictionary);
      return Stream.value(GetDictionaryAction(dictionary: action.dictionary));
    });
  }
}
