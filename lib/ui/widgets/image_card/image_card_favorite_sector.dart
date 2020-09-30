import 'package:flutter/material.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/res/icons/bottom_bar_icons.dart';

import 'package:pictures_view/theme/custom_theme.dart';

class ImageCardFavoriteSector extends StatefulWidget {
  final bool isLiked;
  final int countOfLikes;
  final BooleanCallback likeCallback;

  const ImageCardFavoriteSector({
    @required this.isLiked,
    @required this.countOfLikes,
    @required this.likeCallback,
    Key key,
  }) : super(key: key);

  @override
  _ImageCardFavoriteSectorState createState() => _ImageCardFavoriteSectorState();
}

class _ImageCardFavoriteSectorState extends State<ImageCardFavoriteSector> {
  bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              BottomBarIcons.favorites,
              size: 12.0,
              color: isLiked ? Color(0xFFE51A1A) : Color(0xFF979797),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          _getLikesCount(widget.countOfLikes.toString()),
          style: CustomTheme.textStyles.w400TextStyle(size: 14.0, height: 1.3),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _onTap() {
    if (widget.likeCallback != null) {
      widget.likeCallback(!widget.isLiked);
    }

    setState(() {
      isLiked = !isLiked;
    });
  }

  static String _getLikesCount(String likes) {
    if (likes.length >= 7) {
      return likes.substring(0, likes.length - 6) + 'M likes';
    }

    if (likes.length >= 4) {
      return likes.substring(0, likes.length - 3) + 'K likes';
    }

    return likes + ' likes';
  }
}
