import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get_version/get_version.dart';

import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/image_assets.dart';
import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/ui/pages/splash_screen/widgets/splash_loader.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String appVersion;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(
        context,
        height: DESIGN_SCREEN_HEIGHT,
        width: DESIGN_SCREEN_WIDTH,
        allowFontScaling: DESIGN_SCREEN_ALLOW_FONT_SCALING,
      );
    });
    updateAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.colors.accentColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 47.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text('PIK', style: CustomTheme.textStyles.titleTextStyle(size: 45.0, height: 1.3)),
                Text('CHA', style: CustomTheme.textStyles.titleTextStyle(size: 45.0, height: 1.3)),
                SizedBox(height: 30.0),
                SplashLoader(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateAppVersion() async {
    String versionName;
    String versionCode;
    String versionPlatform;

    try {
      versionName = await GetVersion.projectVersion;
      logger.d('Version Name: $versionName');
    } on PlatformException {
      logger.e('Failed to get project version.');
      versionName = null;
    }

    try {
      versionCode = await GetVersion.projectCode;
      logger.d('Version Code: $versionCode');
    } on PlatformException {
      logger.e('Failed to get code version.');
      versionCode = null;
    }

    try {
      versionPlatform = await GetVersion.platformVersion;
      logger.d('Version Platform: $versionPlatform');
    } on PlatformException {
      logger.e('Failed to get platform version.');
      versionPlatform = null;
    }

    setState(() {
      appVersion = '$versionPlatform \n $versionName + $versionCode';
    });
  }
}
