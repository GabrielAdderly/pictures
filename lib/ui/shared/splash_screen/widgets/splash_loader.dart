import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_gradient.dart';

// ignore: use_key_in_widget_constructors
class SplashLoader extends StatefulWidget {
  @override
  _SplashLoaderState createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4, milliseconds: 500), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = Tween<double>(begin: 0.0, end: context.size.width).animate(controller)
        ..addListener(() => setState(() {}));
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(11.0),
            ),
          ),
          Container(
            width: animation?.value ?? 0,
            decoration: BoxDecoration(
              gradient: AppGradient.mainGradient,
              borderRadius: BorderRadius.circular(11.0),
            ),
          )
        ],
      ),
    );
  }
}
