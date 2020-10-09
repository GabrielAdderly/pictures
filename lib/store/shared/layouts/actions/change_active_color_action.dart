import 'package:flutter/material.dart';

import 'package:pictures_view/store/shared/base_action.dart';
import 'package:pictures_view/theme/custom_theme.dart';

class ChangeActiveColorAction extends BaseAction {
  final Color color;
  final ColorType colorType;

  ChangeActiveColorAction({
    @required this.color,
    @required this.colorType,
  }) : super(type: 'ChangeActiveColor');
}
