import 'package:flutter/material.dart';

import 'package:pictures_view/res/const.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final PreferredSizeWidget appBar;
  final bool resizeToAvoidBottomPadding;

  const MainLayout({
    Key key,
    this.appBar,
    this.bgColor,
    this.child,
    this.resizeToAvoidBottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      appBar: appBar,
      backgroundColor: bgColor,
      body: AnimatedContainer(
        color: bgColor,
        width: double.infinity,
        height: double.infinity,
        duration: kAVThemeChangeDuration,
        child: child,
      ),
    );
  }
}
