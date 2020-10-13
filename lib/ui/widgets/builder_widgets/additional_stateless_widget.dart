import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pictures_view/theme/theme_service.dart';
import 'package:pictures_view/theme/models/custom_theme.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

abstract class AdditionalAppbarWidget extends Widget {
  bool get isNotEmpty;

  double get getHeight;

  const AdditionalAppbarWidget({Key key}) : super(key: key);
}

abstract class AdditionalStatelessWidget extends StatelessWidget implements AdditionalAppbarWidget {
  @protected
  final double height;

  @override
  bool get isNotEmpty => height > 0;

  @override
  double get getHeight => height;

  @mustCallSuper
  const AdditionalStatelessWidget({Key key, this.height}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, CustomTheme theme, Dictionary dictionary);

  @override
  Widget build(BuildContext context) {
    return buildWidget(
      context,
      ThemeService.getCurrentTheme,
      FlutterDictionary.instance.dictionary,
    );
  }
}

class NonAdditionalStatelessWidget extends AdditionalStatelessWidget {
  const NonAdditionalStatelessWidget({Key key}) : super(key: key, height: 0.0);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme, Dictionary dictionary) {
    return const SizedBox();
  }
}

abstract class AdditionalStatefulWidget extends StatefulWidget implements AdditionalAppbarWidget {
  final double height;

  @mustCallSuper
  const AdditionalStatefulWidget({Key key, this.height}) : super(key: key);

  @override
  bool get isNotEmpty => height > 0;

  @override
  double get getHeight => height;
}

abstract class AdditionalState<T extends AdditionalStatefulWidget> extends State<T> {
  @protected
  Widget buildWidget(BuildContext context, CustomTheme theme, Dictionary dictionary) => SizedBox();

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return buildWidget(
      context,
      ThemeService.getCurrentTheme,
      FlutterDictionary.instance.dictionary,
    );
  }
}
