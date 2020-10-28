import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pictures_view/res/const.dart';

import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/pages/settings_page/settings_page.dart';

void main() {
  group('test', () {
    Store<AppState> store;

    Widget testAppWidget({Widget child}) {
      return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          home: child,
        ),
      );
    }

    setUpAll(() {
      store = Store<AppState>(
        AppState.getReducer,
        initialState: AppState.initial(),
        middleware: [
          EpicMiddleware(AppState.getAppEpic),
          NavigationMiddleware<AppState>(),
        ],
      );
    });

    testWidgets(kEmptyString, (WidgetTester tester) async {
      await tester.pumpWidget(testAppWidget(child: SettingsPage()));

      await tester.tap(find.byKey(Key('MainAppBar')));
    });
  });
}


