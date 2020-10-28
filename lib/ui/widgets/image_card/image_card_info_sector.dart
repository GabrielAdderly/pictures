import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

class ImageCardInfoSector extends ThemeStatelessWidget {
  final String title;
  final String content;

  const ImageCardInfoSector({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: theme.textStyles.primaryTextStyle(size: 16.0, height: 1.1),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.0),
          Text(
            content,
            style: theme.textStyles.w400TextStyle(size: 12.0, height: 1.2),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
