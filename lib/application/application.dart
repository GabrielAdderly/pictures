import 'package:flutter/material.dart';
import 'package:pictures_view/handler/route_handler.dart';
import 'package:pictures_view/store/shared/initialization/initialize_selector.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/bottom_bar.dart';
import 'package:pictures_view/ui/pages/splash_screen/splash_screen.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/helpers/route_helper.dart';

import 'package:pictures_view/dictionary/flutter_delegate.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/pages/home_page/home_page.dart';

class Application extends StatelessWidget {
  final Store<AppState> store;

  Application({this.store}) : super(key: Key('Application'));

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, AppState>(
        converter: (Store<AppState> store) => store.state,
        onInitialBuild: (AppState state) => InitializeSelectors.startInitialization(store),
        builder: (BuildContext context, AppState store) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigatorHolder.navigatorKey,
            onGenerateRoute: RouteHelper.onGenerateRoute,
            home: SplashScreen(),
            locale: Locale(BASE_LOCALE),
            supportedLocales: FlutterDictionaryDelegate.getSupportedLocales,
            localizationsDelegates: FlutterDictionaryDelegate.getLocalizationDelegates,
            builder: (BuildContext context, Widget child) {
              return Material(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    child,
                    if (RouteHandler.instance.isNotEmptyPages) BottomBar(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}