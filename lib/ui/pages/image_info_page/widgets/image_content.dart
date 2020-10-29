import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/widgets/divider.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

class ImageContent extends ThemeStatelessWidget {
  final CardDTO image;
  final bool isOpened;
  final ScrollController controller;

  ImageContent({
    @required this.image,
    @required this.isOpened,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return SingleChildScrollView(
      controller: controller,
      physics: isOpened ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40.0),
          Text(
            image.title,
            style: theme.textStyles.primaryTextStyle(size: 30.0),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1500),
            opacity: isOpened ? 1 : 0,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                AppDivider(margin: EdgeInsets.symmetric(horizontal: 60.0)),
                const SizedBox(height: 14.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    image.content,
                    style: theme.textStyles.w400TextStyle(size: 20.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 90.0),
        ],
      ),
    );
  }
}
