import 'package:flutter/material.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

abstract class PikchaStatelessWidget extends StatelessWidget {
  PikchaStatelessWidget({Key key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, AVTheme theme, Language dictionary);

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, CustomTheme.getCurrentTheme, FlutterDictionary.instance.language);
  }
}
