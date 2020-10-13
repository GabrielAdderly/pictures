import 'package:flutter/material.dart';
import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/app_styles/app_gradient.dart';

class SplashLoader extends StatefulWidget {
  const SplashLoader({Key key}) : super(key: key);

  @override
  _SplashLoaderState createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader> with TickerProviderStateMixin {
  Animation<double> _loadingAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4, milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback(bindingsInitAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
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
              color: AppColors.kWhiteDark2,
              borderRadius: BorderRadius.circular(11.0),
            ),
          ),
          Container(
            width: _loadingAnimation?.value ?? 0,
            decoration: BoxDecoration(
              gradient: AppGradient.mainGradient,
              borderRadius: BorderRadius.circular(11.0),
            ),
          )
        ],
      ),
    );
  }

  void bindingsInitAnimation(Duration timeStamp) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _loadingAnimation = Tween<double>(begin: 0.0, end: context.size.width).animate(curvedAnimation);
    _animationController.forward();
  }
}
