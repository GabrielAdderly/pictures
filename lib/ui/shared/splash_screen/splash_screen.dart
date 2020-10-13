import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_version/get_version.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/ui/shared/splash_screen/widgets/splash_loader.dart';

class SplashScreen extends ThemeStatefulWidget {
  const SplashScreen({Key key}) : super (key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ThemeState<SplashScreen> {
  String appVersion;

  @override
  void initState() {
    super.initState();
    updateAppVersion();
    WidgetsBinding.instance.addPostFrameCallback(bindingsInitScreenUtil);
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme avTheme) {
    final CustomTheme theme = avTheme ?? darkTheme;
    return Scaffold(
      backgroundColor: theme.colors.accentColor,
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
                Text('PIK', style: theme.textStyles.titleTextStyle(size: 45.0, height: 1.3)),
                Text('CHA', style: theme.textStyles.titleTextStyle(size: 45.0, height: 1.3)),
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

  void bindingsInitScreenUtil(Duration callback) {
    ScreenUtil.init(
      context,
      height: DESIGN_SCREEN_HEIGHT,
      width: DESIGN_SCREEN_WIDTH,
      allowFontScaling: DESIGN_SCREEN_ALLOW_FONT_SCALING,
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
