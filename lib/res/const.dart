import 'package:logger/logger.dart';
import 'package:pictures_view/models/models/route_info.dart';
import 'package:pictures_view/res/routes.dart';

final Logger logger = Logger();

const Duration MILLISECONDS_300 = Duration(milliseconds: 300);

const String LOCALE_EN = 'en';
const String DATA = 'data';

const String BASE_LOCALE = LOCALE_EN;

const String LOCALE_HE = 'he'; // Hebrew
const String LOCALE_PS = 'ps'; // Pashto
const String LOCALE_UR = 'ur'; // Urdu
const String LOCALE_AR = 'ar'; // Arabic
const String LOCALE_FA = 'fa'; // Farsi

//region [ROUTE INFO]

const RouteInfo ROUTE_INFO_HOME_PAGE = RouteInfo(
  route: Routes.home,
  level: RouteInfo.FIRST_LEVEL,
);

const RouteInfo ROUTE_INFO_SETTINGS_PAGE = RouteInfo(
  route: Routes.settings,
  level: RouteInfo.FIRST_LEVEL,
);

const RouteInfo ROUTE_INFO_FAVORITES_PAGE = RouteInfo(
  route: Routes.favorites,
  level: RouteInfo.FIRST_LEVEL,
);

const RouteInfo ROUTE_INFO_IMAGE_INFO_PAGE = RouteInfo(
  route: Routes.imageInfoPage,
  level: RouteInfo.SECOND_LEVEL,
);

const RouteInfo ROUTE_INFO_CUSTOM_COLOR_PICKER_PAGE = RouteInfo(
  route: Routes.customColorPickerPage,
  level: RouteInfo.SECOND_LEVEL,
);

//endregion

const bool DESIGN_SCREEN_ALLOW_FONT_SCALING = true;
const double DESIGN_SCREEN_HEIGHT = 812.0;
const double DESIGN_SCREEN_WIDTH = 375.0;
const Duration kAVThemeChangeDuration = Duration(seconds: 1);