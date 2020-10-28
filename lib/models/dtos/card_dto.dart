import 'package:flutter/foundation.dart';

import 'package:pictures_view/models/interfaces/i_card.dart';
import 'package:pictures_view/res/const.dart';

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

  factory CardDTO.empty() {
    return CardDTO(
      id: kEmptyString,
      title: kEmptyString,
      content: kEmptyString,
      imageUrl: kEmptyString,
    );
  }

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String imageUrl;

  final List<String> tags;

  bool isLiked;
  int likesCount;

  void updateLikes() {
    if (isLiked) {
      incrementLikes();
    } else {
      decrementLikes();
    }
  }

  void incrementLikes() {
    likesCount++;
  }

  void decrementLikes() {
    if (likesCount <= 0) {
      likesCount = 0;
      return;
    }

    likesCount--;
  }

  // ignore: missing_return
  CardDTO fromJson() {}

  // ignore: missing_return
  CardDTO toJson() {}
}
