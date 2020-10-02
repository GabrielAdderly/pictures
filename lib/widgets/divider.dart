import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

// ignore: use_key_in_widget_constructors
class AppDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1.0, color: AppColors.kDivider);
  }
}
