import 'package:flutter/material.dart';

import 'package:pictures_view/theme/interfaces/i_appvesto_text_theme.dart';

class AVTextStyles implements IAVTextStyles {
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

  @override
  TextStyle titleTextStyle({double size = 20.0, double height = 1.0}) {
    return TextStyle(
      fontFamily: titleFontFamily,
      height: height,
      fontSize: size,
      color: mainTextColor,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  TextStyle primaryTextStyle({double size, double height}) {
    // TODO: implement primaryTextStyle
    throw UnimplementedError();
  }
}
