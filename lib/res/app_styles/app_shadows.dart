import 'package:flutter/cupertino.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

class AppShadows {
  static final List<BoxShadow> bottomBarItemShadow = [
    BoxShadow(
      offset: Offset(4.0, 2.0),
      color: AppColors.kBlackShadow.withOpacity(0.18),
      spreadRadius: 0,
      blurRadius: 16.0,
    ),
    BoxShadow(
      offset: Offset(-4.0, -2.0),
      color: AppColors.kBlackLightShadow,
      blurRadius: 16.0,
      spreadRadius: 0,
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
