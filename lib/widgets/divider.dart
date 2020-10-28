import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

class AppDivider extends StatelessWidget {
  final EdgeInsets margin;

  const AppDivider({Key key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        height: 1.0,
        color: AppColors.kDivider,
      ),
    );
  }
}
