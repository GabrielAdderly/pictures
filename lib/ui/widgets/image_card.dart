import 'package:flutter/material.dart';
import 'package:pictures_view/ui/extensions/widget_extensions.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    @required Key key,
    @required this.card,
    @required this.onTap,
  }) :  assert(key != null, 'Key must be not null'),
        assert(card != null, 'Card (key: $key) must be not null'),
        assert(card.imageUrl != null && card.imageUrl.startsWith('http'),
        'Card (key: $key) imageUrl should start with "http"'
        ),
        super(key: key);

  final CardDTO card;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final double _width = double.infinity;

    return Container(
      width: _width,
      decoration: BoxDecoration(
        color: Color(0xFF16191D),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        )
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: _width - 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  card.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ).aspectRatio(1.3),
          SizedBox(
            height: 10.0,
          ),
          Text(
            card.title,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2.0,
          ),
          Expanded(
            child: Text(
              card.content,
              style: TextStyle(
                color: Color(0xFF979797),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.favorite,
                size: 16,
                color: card.isLiked
                    ? Color(0xFFE51A1A)
                    : Color(0xFF979797),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                getLikesCount(card.likesCount.toString()),
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    ).aspectRatio(0.82)
     .onTap(onTap ?? () {});
  }
}

String getLikesCount(String likes) {
  if (likes.length >= 7) {
    return likes.substring(0, likes.length - 6) + 'M likes';
  }

  if (likes.length >= 4) {
    return likes.substring(0, likes.length - 3) + 'K likes';
  }

  return likes + ' likes';
}

class CardDTO implements ICard {
  CardDTO({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.imageUrl,

    this.isLiked = false,
    this.likesCount = 0,
    this.tags = const [],
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String imageUrl;

  final List<String> tags;

  final bool isLiked;
  final int likesCount;

  Card fromJson() {}
  Card toJson() {}
}

abstract class ICard {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  ICard({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.imageUrl,
  });
}