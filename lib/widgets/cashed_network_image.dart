import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/image_assets.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const CachedImage({
    @required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
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
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0.0),
      child: AnimatedContainer(
        width: width,
        duration: MILLISECONDS_300,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          fit: fit,
          placeholder: (BuildContext context, String url) {
            return Image.asset(
              ImageAssets.LOADING,
              height: height,
              width: width,
              fit: fit,
            );
          },
        ),
      ),
    );
  }
}
