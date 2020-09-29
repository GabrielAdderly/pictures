import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

class AppGradient {
  static LinearGradient get mainGradient {
    return LinearGradient(
      colors: <Color>[
        AppColors.kPeach,
        AppColors.kYellowLight ,
        AppColors.kPinkLight,
        AppColors.kRedLight,
      ],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      stops: [0, 0.4, 0.6, 1.0],
    );
  }
}