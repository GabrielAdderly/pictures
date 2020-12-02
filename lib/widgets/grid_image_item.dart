import 'package:flutter/material.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card.dart';

class GridImageItem extends StatelessWidget {
  final CardDTO card;
  final OnTapFunction onTap;
  final double width;
  final double height;
  final bool isExpanded;
  final bool isBigLikeVisible;
  final EdgeInsets padding;

  const GridImageItem({
    @required this.card,
    @required this.onTap,
    this.width,
    this.height,
    this.isExpanded,
    this.isBigLikeVisible,
    this.padding = const EdgeInsets.all(8.0),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ImageCard(
        key: Key('image_card_${card.id}'),
        card: card,
        onTap: onTap,
        width: width,
        height: height,
        isExpanded: isExpanded,
        isBigLikeVisible: isBigLikeVisible,
        likeCallback: (bool isLiked) => card.updateLikes(),
      ),
    );
  }
}
