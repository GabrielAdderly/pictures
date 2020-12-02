import 'package:flutter/material.dart';
import 'package:pictures_view/pic_main_lib.dart';

class ListColumnBuilder extends ThemeStatelessWidget {
  final int itemCount;
  final Widget Function(int index) builder;

  ListColumnBuilder({
    @required this.builder,
    @required this.itemCount,
    Key key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Column(
      children: [
        for (int i = 0; i < itemCount; i++) builder(i),
        const SizedBox(height: 14.0),
      ],
    );
  }
}
