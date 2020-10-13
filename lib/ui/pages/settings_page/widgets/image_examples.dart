import 'package:flutter/material.dart';

import 'package:pictures_view/dummy_classes/dummy_image_list.dart';

import 'package:pictures_view/ui/widgets/image_card/image_card.dart';

class ImageExamples extends StatelessWidget {
  ImageExamples() : super(key: Key('Examples Images Key'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 15.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: ImageCard(
              key: Key('test 1'),
              height: 250.0,
              card: dummyImageList[0],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: ImageCard(
              key: Key('test 2'),
              height: 250.0,
              card: dummyImageList[1],
            ),
          ),
        ],
      ),
    );
  }
}
