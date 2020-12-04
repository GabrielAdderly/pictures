import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/ui/widgets/favorite_button.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card_info_sector.dart';
import 'package:pictures_view/ui/widgets/image_card/image_card_picture_sector.dart';
import 'package:pictures_view/ui/widgets/image_card/image_card_favorite_sector.dart';

class ImageCard extends ThemeStatefulWidget {
  ImageCard({
    @required Key key,
    @required this.card,
    this.isCardExpanded = false,
    this.isBigLikeVisible = false,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.likeCallback,
  })  : assert(key != null, 'Key must be not null'),
        assert(card != null, 'Card (key: $key) must be not null'),
        assert(card.imageUrl != null && card.imageUrl.startsWith('http'),
            'Card (key: $key) imageUrl should start with "http"'),
        super(key: key);

  final CardDTO card;
  final double width;
  final double height;
  final EdgeInsets padding;
  final OnTapFunction onTap;
  final bool isCardExpanded;
  final bool isBigLikeVisible;
  final BooleanCallback likeCallback;

  @override
  State<StatefulWidget> createState() => _ImageCardState();
}

class _ImageCardState extends ThemeState<ImageCard> {

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 550),
      height: widget.height,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: widget.isCardExpanded ? EdgeInsets.zero : widget.padding,
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: widget.isCardExpanded ? 0.0 : 1.0,
            child: Column(
              children: <Widget>[
                const Spacer(flex: 2),
                const SizedBox(height: 10.0),
                Expanded(
                  child: _infoBlock(),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: _getHeight(widget.height),
              child: ImageCardPictureSector(imageUrl: widget.card.imageUrl),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: widget.isBigLikeVisible ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: !widget.isBigLikeVisible,
                  child: FavoriteButton(
                    size: 25.0,
                    isLiked: widget.card.isLiked,
                    likeCallback: widget.likeCallback,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoBlock({MainAxisAlignment mainAlignment = MainAxisAlignment.spaceBetween}) {
    return Column(
      mainAxisAlignment: mainAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ImageCardInfoSector(
          title: widget.card.title,
          content: widget.card.content,
        ),
        if (mainAlignment == MainAxisAlignment.center) const SizedBox(height: 10.0),
        ImageCardFavoriteSector(
          isLiked: widget.card.isLiked,
          countOfLikes: widget.card.likesCount,
          likeCallback: widget.likeCallback,
        ),
      ],
    );
  }

  double _getHeight(double widgetHeight) {
    if (!widget.isCardExpanded) return widgetHeight * 0.57;
    if (widget.isCardExpanded) return widgetHeight;
    return widgetHeight * 0.57;
  }
}
