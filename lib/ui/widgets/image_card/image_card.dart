import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card_info_sector.dart';
import 'package:pictures_view/ui/widgets/image_card/image_card_picture_sector.dart';
import 'package:pictures_view/ui/widgets/image_card/image_card_favorite_sector.dart';

class ImageCard extends ThemeStatelessWidget {
  ImageCard({
    @required Key key,
    @required this.card,
    this.onTap,
    this.likeCallback,
    this.height,
    this.width,
  })  : assert(key != null, 'Key must be not null'),
        assert(card != null, 'Card (key: $key) must be not null'),
        assert(card.imageUrl != null && card.imageUrl.startsWith('http'),
            'Card (key: $key) imageUrl should start with "http"'),
        super(key: key);

  final double width;
  final double height;
  final CardDTO card;
  final OnTapFunction onTap;
  final BooleanCallback likeCallback;

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onTap,
              child: ImageCardPictureSector(imageUrl: card.imageUrl),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ImageCardInfoSector(
                  title: card.title,
                  content: card.content,
                ),
                const SizedBox(height: 8.0),
                ImageCardFavoriteSector(
                  isLiked: card.isLiked,
                  countOfLikes: card.likesCount,
                  likeCallback: likeCallback,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
