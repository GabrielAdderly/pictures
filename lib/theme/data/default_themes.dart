import 'package:pictures_view/res/app_styles/app_colors.dart';

import 'package:pictures_view/theme/models/custom_theme.dart';
import 'package:pictures_view/theme/models/custom_theme_colors.dart';
import 'package:pictures_view/theme/models/custom_theme_text_styles.dart';

CustomTheme darkTheme = CustomTheme(
  themeName: 'Dark',
  colors: CustomThemeColors(
    primaryColor: AppColors.kBlack,
    accentColor: AppColors.kBlackLight,
    iconColor: AppColors.kOrange,
    buttonColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
    backgroundColor: AppColors.kBlack,
  ),
  textStyles: CustomThemeTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily: 'SF Pro Display',
    mainTextColor: AppColors.kWhite,
    additionalTextColor: AppColors.kGreyTwo,
  ),
);

CustomTheme lightTheme = CustomTheme(
  themeName: 'Light',
  colors: CustomThemeColors(
    primaryColor: AppColors.kWhite,
    accentColor: AppColors.kWhiteDark,
    iconColor: AppColors.kOrange,
    buttonColor: AppColors.kOrange,
    inActiveColor: AppColors.kGreyTwo,
    backgroundColor: AppColors.kWhite,
  ),
  textStyles: CustomThemeTextStyles(
    titleFontFamily: 'EXIL71',
    textFontFamily: 'SF Pro Display',
    mainTextColor: AppColors.kBlack,
    additionalTextColor: AppColors.kGreyTwo,
  ),
);
