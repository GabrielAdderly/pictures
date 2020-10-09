import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/layouts/main_layout/main_layout_view_model.dart';

abstract class PikchaStatelessWidget extends StatelessWidget {
  PikchaStatelessWidget({Key key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, AVTheme theme, Dictionary dictionary);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayoutViewModel>(
      converter: LayoutViewModel.fromStore,
      builder: (BuildContext context, LayoutViewModel viewModel) {
        return buildWidget(
          context,
          viewModel.theme,
          viewModel.dictionary,
        );
      },
    );
  }
}

abstract class PikchaStatefulWidget extends StatefulWidget {
  const PikchaStatefulWidget({Key key}) : super(key: key);
}

abstract class PikchaState<T extends PikchaStatefulWidget> extends State<T> {
  @protected
  Widget buildWidget(BuildContext context, AVTheme theme, Dictionary dictionary);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayoutViewModel>(
      converter: LayoutViewModel.fromStore,
      builder: (BuildContext context, LayoutViewModel viewModel) {
        return buildWidget(
          context,
          viewModel.theme,
          viewModel.dictionary,
        );
      },
    );
  }
}
