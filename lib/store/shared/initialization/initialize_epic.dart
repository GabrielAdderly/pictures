import 'package:rxdart/rxdart.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/theme/theme_service.dart';
import 'package:pictures_view/handler/route_handler.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/layouts/actions/layout_actions.dart';
import 'package:pictures_view/store/shared/initialization/actions/start_initialization.dart';

class InitializeEpics {
  static final indexEpic = combineEpics<AppState>([
    initializationEpic,
    initializationThemeEpic,
  ]);

  static Stream<dynamic> initializationEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<StartInitialization>().switchMap((action) async* {
      yield* await Future.delayed(Duration(seconds: 5)).then((_) {
        return Stream.fromIterable([
          RouteHandler.instance.navigateTo(ROUTE_INFO_HOME_PAGE),
          GetDictionaryAction(dictionary: FlutterDictionary.instance.dictionary),
        ]);
      });
    });
  }

  static Stream<dynamic> initializationThemeEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<StartInitialization>().switchMap((action) async* {
      await ThemeService.instance.init();
      yield* Stream.value(GetThemeAction(theme: ThemeService.getCurrentTheme));
    });
  }
}