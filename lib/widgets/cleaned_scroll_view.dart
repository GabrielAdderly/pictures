import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';

class CleanedScrollView extends StatelessWidget {
  final ScrollController controller;
  final List<Widget> children;
  final Axis scrollDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CleanedScrollView({
    @required this.children,
    this.controller,
    Key key,
    this.scrollDirection = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : assert(children != null, 'Bad State. The CleanScrollView must have children'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CleanBehavior(),
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        controller: controller,
        child: _body,
      ),
    );
  }

  // ignore: missing_return
  Widget get _body {
    switch (scrollDirection) {
      case Axis.horizontal:
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
      case Axis.vertical:
        return Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
    }
  }
}
