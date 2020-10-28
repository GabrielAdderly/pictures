import 'package:logger/logger.dart';
import 'package:pictures_view/models/models/route_info.dart';
import 'package:pictures_view/res/routes.dart';

final Logger logger = Logger();

const Duration MILLISECONDS_300 = Duration(milliseconds: 300);

const String kEmptyString = '';
const String kSpaceString = ' ';
const String kLocaleEn = 'en';
const String kData = 'data';

const String kBaseLocale = kLocaleEn;

const String kLocaleHe = 'he'; // Hebrew
const String kLocalePs = 'ps'; // Pashto
const String kLocaleUr = 'ur'; // Urdu
const String kLocaleAr = 'ar'; // Arabic
const String kLocaleFa = 'fa'; // Farsi

//region [ROUTE INFO]

const RouteInfo kRouteInfoHomePage = RouteInfo(
  route: Routes.home,
  level: RouteInfo.kFirstLevel,
);

const RouteInfo kRouteInfoSettingsPage = RouteInfo(
  route: Routes.settings,
  level: RouteInfo.kFirstLevel,
);

const RouteInfo kRouteInfoFavoritesPage = RouteInfo(
  route: Routes.favorites,
  level: RouteInfo.kFirstLevel,
);

const RouteInfo kRouteInfoImageInfoPage = RouteInfo(
  route: Routes.imageInfoPage,
  level: RouteInfo.kSecondLevel,
);

const RouteInfo kRouteInfoCustomColorPickerPage = RouteInfo(
  route: Routes.customColorPickerPage,
  level: RouteInfo.kSecondLevel,
);
//endregion

const double kDesignScreenHeight = 812.0;
const double kDesignScreenWidth = 375.0;
const Duration kAVThemeChangeDuration = Duration(seconds: 1);
const Duration kBaseChangeDuration = Duration(seconds: 1);