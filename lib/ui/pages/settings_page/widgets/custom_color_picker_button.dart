import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/res/image_assets.dart';

import 'package:pictures_view/res/typedef.dart';

class CustomColorPickerButton extends ThemeStatelessWidget {
  final double size;
  final OnTapFunction onTap;

  const CustomColorPickerButton({
    @required Key key,
    @required this.onTap,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset(ImageAssets.ColorsPicker),
        ),
      ),
    );
  }
}
