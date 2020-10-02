import 'package:flutter/material.dart';

class AVTextStyles {
  final String titleFontFamily;
  final String textFontFamily;
  final Color mainTextColor;
  final Color additionalTextColor;

  const AVTextStyles({
    @required this.titleFontFamily,
    @required this.textFontFamily,
    @required this.mainTextColor,
    this.additionalTextColor,
  });

  TextStyle titleTextStyle({double size = 20.0, double height = 1.0}) {
    return TextStyle(
      fontFamily: titleFontFamily,
      height: height,
      fontSize: size,
      color: mainTextColor,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle primaryTextStyle({double size, double height}) {
    return TextStyle(
      fontFamily: textFontFamily,
      height: height,
      fontSize: size,
      color: mainTextColor,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle w400TextStyle({double size, double height}) {
    return TextStyle(
      fontFamily: textFontFamily,
      height: height,
      fontSize: size,
      color: additionalTextColor,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle boldTextStyle({double size, double height}) {
    return TextStyle(
      fontFamily: textFontFamily,
      height: height,
      fontSize: size,
      color: mainTextColor,
      fontWeight: FontWeight.bold,
    );
  }
}
