import 'package:flutter/material.dart';
import 'package:pictures_view/handler/route_handler.dart';

import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/routes.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/bottom_bar.dart';
import 'package:pictures_view/ui/pages/custom_color_picker_page/custom_color_picker_page.dart';
import 'package:pictures_view/ui/pages/favorites_page/favorites_page.dart';

import 'package:pictures_view/ui/pages/home_page/home_page.dart';
import 'package:pictures_view/ui/pages/image_info_page/image_info_page.dart';
import 'package:pictures_view/ui/pages/settings_page/settings_page.dart';
import 'package:pictures_view/ui/pages/next_button_page/next_button_page.dart';

import 'package:pictures_view/ui/shared/unknown_page/unknown_page.dart';
import 'package:pictures_view/ui/shared/splash_screen/splash_screen.dart';

class RouteHelper {
  static const String tag = '[RouteHelper]';

  static Material pageBuilder(BuildContext context, Widget child) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          child,
          if (RouteHandler.instance.isNotEmptyPages) BottomBar(),
        ],
      ),
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _defaultRoute(
          settings: settings,
          page: SplashScreen(),
        );

      case Routes.home:
        return _defaultRoute(
          settings: settings,
          page: HomePage(),
        );

      case Routes.nextButton:
        return _defaultRoute(
          settings: settings,
          page: NextButtonPage(),
        );

      case Routes.settings:
        return _defaultRoute(
          settings: settings,
          page: SettingsPage(),
        );

      case Routes.favorites:
        return _defaultRoute(
          settings: settings,
          page: FavoritesPage(),
        );

      case Routes.customColorPickerPage:
        return _defaultRoute(
          settings: settings,
          page: CustomColorPickerPage(),
        );

      case Routes.imageInfoPage:
        return _defaultRoute(
          settings: settings,
          page: ImageInfoPage(),
        );

      default:
        logger.w('$tag => <onGenerateRoute> => invalid route!!! => ${settings.name}');
        return _defaultRoute(
          settings: settings,
          page: UnknownPage(),
        );
    }
  }

  static Route<dynamic> _defaultRoute({RouteSettings settings, Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) {
        return page;
      },
      transitionDuration: const Duration(),
    );
  }
}