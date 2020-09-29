import 'package:flutter/material.dart';
import 'package:pictures_view/models/interfaces/i_model.dart';

class ColorSchemeModel implements IModel {
  final List<Color> colors;

  ColorSchemeModel({
    this.colors,
  });
}
