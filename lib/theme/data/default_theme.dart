import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_edge_insets.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

AVTheme darkTheme = AVTheme(
  themeName: 'Dark',
  colors: AVColors(
    primaryColor: AppColors.kBlack,
    accentColor: AppColors.kBlackLight,
    iconColor: AppColors.kOrange,
    buttonColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
    backgroundColor: AppColors.kBlack,
  ),
  textStyles: AVTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily: 'SF Pro Display',
    mainTextColor: AppColors.kWhite,
    additionalTextColor: AppColors.kGreyTwo,
  ),
);

AVTheme lightTheme = AVTheme(
  themeName: 'Light',
  colors: AVColors(
    primaryColor: AppColors.kWhite,
    accentColor: AppColors.kWhiteDark,
    iconColor: AppColors.kOrange,
    buttonColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
    backgroundColor: AppColors.kWhite,
  ),
  textStyles: AVTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily: 'SF Pro Display',
    mainTextColor: AppColors.kBlack,
    additionalTextColor: AppColors.kGreyTwo,
  ),
);
