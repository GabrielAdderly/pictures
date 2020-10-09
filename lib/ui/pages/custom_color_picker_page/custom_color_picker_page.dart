import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';
import 'package:pictures_view/ui/pages/custom_color_picker_page/widgets/custom_color_picker_body.dart';

class CustomColorPickerPage extends PageWidget {
  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return MainAppBar(title: 'SETTINGS');
  }

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Dictionary dictionary) {
    return CustomColorPickerBody();
  }
}