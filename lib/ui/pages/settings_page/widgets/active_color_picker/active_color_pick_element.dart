import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';

class ActiveColorPickElement extends ThemeStatelessWidget {
  static const double kBorderSize = 4.0;
  final Color color;
  final double size;
  final bool isSelected;
  final ChooseColorFunction chooseActiveColor;

  const ActiveColorPickElement({
    @required Key key,
    @required this.color,
    @required this.isSelected,
    @required this.chooseActiveColor,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          chooseActiveColor(
            color,
            ColorType.icon,
          );
          chooseActiveColor(
            color,
            ColorType.button,
          );
        },
        child: Container(
          height: _getSize,
          width: _getSize,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(width: isSelected ? kBorderSize : 0, color: theme.colors.inActiveColor),
            borderRadius: BorderRadius.circular(_getRoundedSize),
          ),
        ),
      ),
    );
  }

  double get _selectedSize => size - kBorderSize;

  double get _getSize => isSelected ? size : _selectedSize;

  double get _getRoundedSize => _getSize / 2;
}