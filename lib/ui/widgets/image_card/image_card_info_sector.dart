import 'package:flutter/material.dart';
import 'package:pictures_view/theme/custom_theme.dart';

class ImageCardInfoSector extends StatelessWidget {
  final String title;
  final String content;

  const ImageCardInfoSector({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: CustomTheme.textStyles.primaryTextStyle(size: 16.0, height: 1.1),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.0),
          Text(
            content,
            style: CustomTheme.textStyles.w400TextStyle(size: 12.0, height: 1.2),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
