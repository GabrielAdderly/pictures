import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/theme/models/appvesto_colors.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout_view_model.dart';

abstract class PageWidget extends StatelessWidget {
  const PageWidget({Key key}) : super(key: key);

  @protected
  PreferredSizeWidget buildAppBar(Dictionary dictionary);

  @protected
  Widget buildBody(BuildContext context, AVTheme theme, Dictionary dictionary);

  @protected
  bool get resizeToAvoidBottomBarPadding => false;

  @protected
  Color backgroundColor(AVColors colors) => colors.accentColor;

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayoutViewModel>(
      distinct: true,
      converter: LayoutViewModel.fromStore,
      builder: (BuildContext context, LayoutViewModel viewModel) {
        print('rebuild');
        return MainLayout(
          key: key,
          bgColor: backgroundColor(viewModel.theme.colors),
          resizeToAvoidBottomPadding: resizeToAvoidBottomBarPadding,
          appBar: buildAppBar(viewModel.dictionary),
          child: buildBody(context, viewModel.theme, viewModel.dictionary),
        );
      },
    );
  }
}