import 'package:flutter/painting.dart';
import 'package:pictures_view/theme/interfaces/i_appvesto_colors.dart';

class AVColors implements IAVColors {
  @override
  Color primaryColor;
  @override
  Color accentColor;
  Color backgroundColor;
  Color likeColor;
  Color unlikeColor;

  Color titleTextColor;
  Color headerTextColor;
  Color textColor;
  Color secondTitleColor;

  AVColors({
    this.primaryColor,
    this.accentColor,
    this.backgroundColor,
    this.likeColor,
    this.unlikeColor,
    this.titleTextColor,
    this.headerTextColor,
    this.textColor,
    this.secondTitleColor,
  });
}