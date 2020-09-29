import 'package:flutter/material.dart';
import 'package:pictures_view/widgets/cashed_network_image.dart';

class ImageExamples extends StatelessWidget {
  ImageExamples() : super(key: Key('Examples Images Key'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20.0,
      ),
      child: Row(
        children: exampleImages,
      ),
    );
  }

  List<CachedImage> get exampleImages {
    return [
      CachedImage.squared(
        size: 200.0,
        imageUrl: 'https://www.freedigitalphotos.net/images/img/homepage/394230.jpg',
      ),
      CachedImage.squared(
        size: 200.0,
        imageUrl: 'https://filedn.com/ltOdFv1aqz1YIFhf4gTY8D7/ingus-info/BLOGS/Photography-stocks3/stock-photography-slider.jpg',
      ),
    ];
  }
}
