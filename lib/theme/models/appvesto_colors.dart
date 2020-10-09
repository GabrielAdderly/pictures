import 'package:flutter/painting.dart';

import 'package:pictures_view/utils/color_converter.dart';

import 'package:pictures_view/theme/dto/theme_colors_dto.dart';

class AVColors {
  Color primaryColor;
  Color accentColor;
  Color backgroundColor;
  Color iconColor;
  Color buttonColor;
  Color inActiveColor;

  AVColors({
    this.primaryColor,
    this.accentColor,
    this.backgroundColor,
    this.iconColor,
    this.buttonColor,
    this.inActiveColor,
  });

  AVColors.empty();

  factory AVColors.fromDTO(ThemeColorsDTO dto) {
    return AVColors(
      accentColor: ColorConverter.hexToColor(dto.accentColor),
      iconColor: ColorConverter.hexToColor(dto.iconColor),
      buttonColor: ColorConverter.hexToColor(dto.buttonColor),
      primaryColor: ColorConverter.hexToColor(dto.primaryColor),
      inActiveColor: ColorConverter.hexToColor(dto.inActiveColor),
      backgroundColor: ColorConverter.hexToColor(dto.backgroundColor),
    );
  }

  ThemeColorsDTO toDTO() {
    return ThemeColorsDTO(
      accentColor: ColorConverter.colorToHex(accentColor),
      iconColor: ColorConverter.colorToHex(iconColor),
      buttonColor: ColorConverter.colorToHex(buttonColor),
      primaryColor: ColorConverter.colorToHex(primaryColor),
      inActiveColor: ColorConverter.colorToHex(inActiveColor),
      backgroundColor: ColorConverter.colorToHex(backgroundColor),
    );
  }
}
