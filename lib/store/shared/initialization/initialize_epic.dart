import 'package:rxdart/rxdart.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/handler/route_handler.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/initialization/actions/start_initialization.dart';

class InitializeEpics {
  static final indexEpic = combineEpics<AppState>([
    initializationEpic,
  ]);

  static Stream<dynamic> initializationEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<StartInitialization>().switchMap((action) {
      return Stream.fromFuture(
        Future.delayed(Duration(seconds: 5)).then((_) {
          return RouteHandler.instance.navigateTo(ROUTE_INFO_HOME_PAGE);
        }),
      );
    });
  }
}
