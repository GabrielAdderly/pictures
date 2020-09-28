import 'package:flutter/material.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_edge_insets.dart';
import 'package:pictures_view/theme/models/appvesto_text_styles.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

AVTheme darkTheme = AVTheme(
  themeName: 'dark_theme',
  colors: AVColors(
    accentColor: Color(0xFFF06500),
    primaryColor: Color(0xFF16191D),
    backgroundColor: Color(0xFF262B2F),
    likeColor: Color(0xFFE51A1A),
    unlikeColor: Color(0xFF979797),
    titleTextColor: Color(0xFFFFFFFF),
    headerTextColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF96A7AF),
    secondTitleColor: Color(0xFFFFFFFF),
  ),
  textStyles: AVTextStyles(
    accentTextStyle: TextStyle(),
    primaryTextStyle: TextStyle(),
  ),
  edgeInsets: AVEdgeInsets(
    primaryEdgeInsets: EdgeInsets.all(16.0),
  ),
);