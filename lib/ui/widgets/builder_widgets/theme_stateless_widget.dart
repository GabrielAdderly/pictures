library theme_stateless_widget;

export 'package:pictures_view/theme/custom_theme.dart';
export 'package:pictures_view/theme/models/appvesto_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

abstract class ThemeStatelessWidget extends StatelessWidget {
  const ThemeStatelessWidget({Key key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, AVTheme theme);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return buildWidget(context, CustomTheme.getCurrentTheme);
  }
}
