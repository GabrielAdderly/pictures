import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/widgets/divider.dart';
import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';

import 'package:pictures_view/ui/pages/settings_page/widgets/image_examples.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/settings_header.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/active_color_picker/active_color_picker.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/custom_theme_picker/custom_theme_picker.dart';

class SettingsPage extends PageWidget {
  SettingsPage() : super(key: Key('SettingsPage'));

  final List<String> list = ['Color theme'];

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return MainAppBar(
      title: 'SETTINGS',
      additionalAppBarElement: SettingsHeader(
        titles: list,
        callback: (int index) {},
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, CustomTheme theme, Dictionary dictionary) {
    return CleanedScrollView(
      children: <Widget>[
        AppDivider(),
        ImageExamples(),
        AppDivider(),
        CustomThemePicker(),
        AppDivider(),
        ActiveColorPicker(),
        AppDivider(),
      ],
    );
  }
}
