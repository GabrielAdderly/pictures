import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_edge_insets.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';

AVTheme darkTheme = AVTheme(
  themeName: 'default_theme',
  colors: AVColors(
    primaryColor: AppColors.kBlack,
    accentColor: AppColors.kBlackLight,
    activeColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
  ),
  textStyles: AVTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily: 'SF Pro Display',
    mainTextColor: AppColors.kWhite,
  ),
  edgeInsets: AVEdgeInsets(
    primaryEdgeInsets: EdgeInsets.all(16.0),
  ),
);

AVTheme lightTheme = AVTheme(
  themeName: 'default_theme',
  colors: AVColors(
    primaryColor: AppColors.kWhite,
    accentColor: AppColors.kWhiteDark,
    activeColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
  ),
  textStyles: AVTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily : 'SF Pro Display',
    mainTextColor: AppColors.kBlack,
  ),
  edgeInsets: AVEdgeInsets(
    primaryEdgeInsets: EdgeInsets.all(16.0),
  ),
);
