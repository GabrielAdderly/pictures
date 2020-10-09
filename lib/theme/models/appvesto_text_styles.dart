import 'package:flutter/material.dart';

import 'package:pictures_view/utils/color_converter.dart';

import 'package:pictures_view/theme/dto/theme_text_styles_dto.dart';

class AVTextStyles {
  String titleFontFamily;
  String textFontFamily;
  Color mainTextColor;
  Color additionalTextColor;

  AVTextStyles({
    @required this.titleFontFamily,
    @required this.textFontFamily,
    @required this.mainTextColor,
    this.additionalTextColor,
  });

  AVTextStyles.empty();

  factory AVTextStyles.fromDTO(ThemeTextStylesDTO dto) {
    return AVTextStyles(
      textFontFamily: dto.textFontFamily,
      titleFontFamily: dto.titleFontFamily,
      mainTextColor: ColorConverter.hexToColor(dto.mainTextColor),
      additionalTextColor: ColorConverter.hexToColor(dto.additionalTextColor),
    );
  }

  ThemeTextStylesDTO toDTO() {
    return ThemeTextStylesDTO(
      textFontFamily: textFontFamily,
      titleFontFamily: titleFontFamily,
      mainTextColor: ColorConverter.colorToHex(mainTextColor),
      additionalTextColor: ColorConverter.colorToHex(additionalTextColor),
    );
  }

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

  TextStyle w500TextStyle({double size, double height}) {
    return TextStyle(
      fontFamily: textFontFamily,
      height: height,
      fontSize: size,
      color: mainTextColor,
      fontWeight: FontWeight.w500,
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
