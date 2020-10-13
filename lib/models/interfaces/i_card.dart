import 'package:flutter/foundation.dart';

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