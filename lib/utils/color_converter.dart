import 'package:flutter/painting.dart';
import 'package:pictures_view/res/const.dart';

class ColorConverter {
  static Color hexToColor(String colorHex) {
    int colorInt;

    try {
      colorInt = int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000;
    } catch (e) {
      logger.e('[ColorConverter] => Error => $e');
      colorInt = 0xFF000000;
    }

    return Color(colorInt);
  }

  static String colorToHex(Color color) {
    return '#' + Color(color.value).toString().split('0xff')[1].split(')')[0];
  }
}
