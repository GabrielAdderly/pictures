import 'package:flutter/cupertino.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';
import 'package:pictures_view/theme/custom_theme.dart';

class AppShadows {
  static final List<BoxShadow> bottomBarItemShadow = [
    BoxShadow(
      offset: Offset(0, 0),
      color: CustomTheme.colors.activeColor.withOpacity(0.3),
      spreadRadius: 0,
      blurRadius: 10.0,
    ),
  ];

  static final List<BoxShadow> bottomBarShadow = [
    BoxShadow(
      offset: Offset(0, 1.0),
      blurRadius: 14.0,
      color: AppColors.kBlackLight,
      spreadRadius: 0,
    ),
  ];
}
