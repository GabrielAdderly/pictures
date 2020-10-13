import 'package:flutter/material.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card.dart';

class GridImageItem extends StatelessWidget {
  final double aspectRatio;
  final CardDTO card;
  final OnTapFunction onTap;

  const GridImageItem({
    @required this.card,
    @required this.aspectRatio,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ImageCard(
          key: Key('image_card_${card.id}'),
          card: card,
          onTap: onTap,
          likeCallback: (bool isLiked) => card.updateLikes(),
        ),
      ),
    );
  }
}
