import 'package:flutter/material.dart';

import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';

import 'package:pictures_view/ui/widgets/builder_widgets/page_widget.dart';

import 'package:pictures_view/ui/pages/settings_page/widgets/image_examples.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/settings_header.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/custom_theme_picker/custom_theme_picker.dart';

class SettingsPage extends PageWidget {
  SettingsPage() : super(key: Key('SettingsPage'));

  final List<String> list = ['Color theme'];

  @override
  PreferredSizeWidget buildAppBar() => MainAppBar(title: 'SETTINGS');

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Language dictionary) {
    return CleanedScrollView(
      children: <Widget>[
        SettingsHeader(
          titles: list,
          callback: (int index) {},
        ),
        Divider(
          height: 1.0,
          color: AppColors.kDivider,
        ),
        ImageExamples(),
        Divider(
          height: 1.0,
          color: AppColors.kDivider,
        ),
        CustomThemePicker(themes: [darkTheme, lightTheme]),
        Divider(
          height: 1.0,
          color: AppColors.kDivider,
        ),
      ],
    );
  }
}
