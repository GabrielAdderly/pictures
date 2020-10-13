import 'package:flutter/cupertino.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

class AppShadows {

  static List<BoxShadow> bottomBarItemShadow(Color color) {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: color.withOpacity(0.5),
        blurRadius: 4.0,
      ),
    ];
  }

  static final List<BoxShadow> bottomBarShadow = [
    BoxShadow(
      offset: Offset(0, 1.0),
      blurRadius: 14.0,
      color: AppColors.kBlackLight,
    ),
  ];
}
