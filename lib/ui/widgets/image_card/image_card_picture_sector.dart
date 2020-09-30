import 'package:flutter/material.dart';
import 'package:pictures_view/widgets/cashed_network_image.dart';

class ImageCardPictureSector extends StatelessWidget {
  final String imageUrl;

  const ImageCardPictureSector({
    this.imageUrl,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedImage(
      height: double.infinity,
      width: double.infinity,
      imageUrl: imageUrl,
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
