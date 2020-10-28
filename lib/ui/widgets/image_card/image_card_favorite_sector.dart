import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/ui/widgets/favorite_button.dart';

class ImageCardFavoriteSector extends ThemeStatelessWidget {
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
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Row(
      children: <Widget>[
        FavoriteButton(
          isLiked: isLiked,
          likeCallback: likeCallback,
        ),
        SizedBox(width: 6.0),
        Text(
          _getLikesCount(countOfLikes.toString()),
          style: theme.textStyles.w400TextStyle(size: 14.0, height: 1.3),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
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
