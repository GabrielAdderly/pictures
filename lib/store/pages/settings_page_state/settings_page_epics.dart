import 'package:rxdart/rxdart.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:pictures_view/theme/custom_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/pages/settings_page_state/actions/change_theme.dart';

class SettingsPageEpics {
  static final indexEpic = combineEpics<AppState>([
    changeThemeEpic,
  ]);

  static Stream<dynamic> changeThemeEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ChangeTheme>().switchMap((action) {
      return Stream.fromIterable([
        CustomTheme.instance.setNewTheme(action.theme),
      ]);
    });
  }
}
