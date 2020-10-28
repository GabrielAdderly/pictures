import 'dart:ui';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/models/models/route_info.dart';
import 'package:pictures_view/theme/models/custom_theme.dart';

typedef OnTapFunction = void Function();

typedef PopFunction = void Function();
typedef NavigateToFunction = void Function(RouteInfo);

typedef BooleanCallback = void Function(bool);

typedef ChangeThemeFunction = void Function(CustomTheme) ;

typedef ChooseColorFunction = void Function(Color, ColorType) ;