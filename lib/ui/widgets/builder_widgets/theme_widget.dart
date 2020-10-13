library theme_stateless_widget;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout_view_model.dart';

abstract class ThemeStatelessWidget extends StatelessWidget {
  const ThemeStatelessWidget({Key key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, AVTheme theme);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayoutViewModel>(
      converter: LayoutViewModel.fromStore,
      builder: (BuildContext context, LayoutViewModel viewModel) {
        return buildWidget(
          context,
          viewModel.theme,
        );
      },
    );
  }
}

abstract class ThemeStatefulWidget extends StatefulWidget {
  const ThemeStatefulWidget({Key key}) : super(key: key);
}

abstract class ThemeState<T extends ThemeStatefulWidget> extends State<T> {
  @protected
  Widget buildWidget(BuildContext context, AVTheme theme);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayoutViewModel>(
      converter: LayoutViewModel.fromStore,
      builder: (BuildContext context, LayoutViewModel viewModel) {
        return buildWidget(
          context,
          viewModel.theme,
        );
      },
    );
  }
}
