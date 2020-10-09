import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/models/models/settings_colors_picker.dart';
import 'package:pictures_view/ui/pages/custom_color_picker_page/widgets/button_color_picker/button_color_picker.dart';

import 'package:pictures_view/ui/pages/settings_page/widgets/settings_header.dart';
import 'package:pictures_view/ui/pages/custom_color_picker_page/widgets/icon_color_picker/icon_color_picker.dart';

class CustomColorPickerBody extends PikchaStatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomColorPickerBodyState();
}

class CustomColorPickerBodyState<CustomColorPickerBody> extends PikchaState {
  int selectedIndex = 0;

  final List<SettingColorsPicker> _widgets = [
    SettingColorsPicker(
      title: 'Icon set',
      child: IconColorPicker(),
    ),
    SettingColorsPicker(
      title: 'Buttons',
      child: ButtonColorPicker(),
    ),
  ];

  @override
  Widget buildWidget(BuildContext context, AVTheme theme, Dictionary dictionary) {
    return Column(
      children: <Widget>[
        SettingsHeader(
          titles: _widgets.map((pickers) => pickers.title).toList(),
          callback: _headersCallback,
        ),
        _widgets[selectedIndex].child,
      ],
    );
  }

  void _headersCallback(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
