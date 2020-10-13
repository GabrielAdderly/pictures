import 'package:flutter/foundation.dart';

import 'package:pictures_view/store/shared/base_action.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';

class ChangeThemeAction extends BaseAction {
  final AVTheme theme;

  ChangeThemeAction({@required this.theme}) : super(type: 'ChangeThemeAction');
}