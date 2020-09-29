import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/image_assets.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  const CachedImage({
    @required this.imageUrl,
    @required this.height,
    @required this.width,
    this.fit = BoxFit.cover,
    Key key,
  }) : super(key: key);

  factory CachedImage.squared({
    String imageUrl,
    double size,
    BoxFit fit,
    Key key,
  }) {
    return CachedImage(
      imageUrl: imageUrl,
      height: size,
      width: size,
      fit: fit,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      duration: MILLISECONDS_300,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        fit: BoxFit.cover,
        placeholder: (BuildContext context, String url) {
          return Image.asset(
            ImageAssets.LOADING,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
