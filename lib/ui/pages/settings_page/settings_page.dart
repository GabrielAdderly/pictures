import 'package:flutter/material.dart';

import 'package:pictures_view/res/app_styles/app_colors.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/image_examples.dart';

import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';

import 'package:pictures_view/ui/pages/settings_page/widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage() : super(key: Key('SettingsPage'));

  final List<String> list = [
    'Color theme',
//    'Text Styles',
//    'Additional Settings',
//    'Color Theme',
//    'Text Styles',
//    'Additional Settings'
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bgColor: CustomTheme.colors.accentColor,
      appBar: MainAppBar(title: 'Settings'.toUpperCase()),
      child: CleanedScrollView(
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
        ],
      ),
    );
  }
}
