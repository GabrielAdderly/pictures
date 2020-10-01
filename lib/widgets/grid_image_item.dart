import 'package:flutter/material.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card.dart';

class GridImageItem extends StatelessWidget {
  final double aspectRatio;
  final CardDTO card;

  const GridImageItem({
    @required this.card,
    @required this.aspectRatio,
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
          onTap: () {},
          likeCallback: (bool isLiked) => card.updateLikes(),
        ),
      ),
    );
  }
}
