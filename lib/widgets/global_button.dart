import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';

class GlobalButton extends ThemeStatelessWidget {
  final double height;
  final Color bgColor;
  final Color borderColor;
  final String text;
  final double textSize;
  final EdgeInsets margin;
  final OnTapFunction onTap;

  GlobalButton({
    @required this.text,
    @required this.onTap,
    this.bgColor,
    this.borderColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0),
    this.height = 50.0,
    this.textSize = 18.0,
    Key key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Padding(
      padding: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: onTap,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor ?? theme.colors.buttonColor,
            border: Border.all(
              color: borderColor ?? bgColor ?? theme.colors.buttonColor,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: theme.textStyles.w500TextStyle(
              size: textSize,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
