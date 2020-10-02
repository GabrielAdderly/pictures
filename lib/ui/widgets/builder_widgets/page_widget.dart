import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/dictionary/models/language.dart';
import 'package:pictures_view/dictionary/flutter_dictionary.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout_view_model.dart';

abstract class PageWidget extends StatelessWidget {
  const PageWidget({Key key}) : super(key: key);

  @protected
  PreferredSizeWidget buildAppBar();

  @protected
  Widget buildBody(BuildContext context, AVTheme theme, Language dictionary);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainLayoutViewModel>(
      converter: MainLayoutViewModel.fromStore,
      builder: (BuildContext context, MainLayoutViewModel viewModel) {
        return MainLayout(
          bgColor: CustomTheme.getCurrentTheme.colors.accentColor,
          appBar: buildAppBar(),
          child: buildBody(context, CustomTheme.getCurrentTheme, FlutterDictionary.instance.language),
        );
      },
    );
  }
}