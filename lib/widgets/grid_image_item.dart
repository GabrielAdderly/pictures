import 'package:flutter/material.dart';

class GridImageItem extends StatelessWidget {
  final double aspectRatio;
  final Widget child;

  const GridImageItem({
    Key key,
    this.aspectRatio,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: child,
      ),
    );
  }
}
