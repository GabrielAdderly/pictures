import 'package:flutter/material.dart';

import 'package:pictures_view/store/shared/base_action.dart';

class ChangeActiveColor extends BaseAction {
  final Color color;

  ChangeActiveColor({@required this.color}) : super(type: 'ChangeActiveColor');
}
