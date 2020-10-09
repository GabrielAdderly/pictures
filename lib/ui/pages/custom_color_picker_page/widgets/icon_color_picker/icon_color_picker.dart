import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_builder.dart';
import 'package:pictures_view/ui/pages/custom_color_picker_page/widgets/icon_color_picker/icon_color_picker_view_model.dart';
import 'package:pictures_view/widgets/global_button.dart';

class IconColorPicker extends ThemeStatefulWidget {
  IconColorPicker({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IconColorPickerState();
}

class _IconColorPickerState extends ThemeState<IconColorPicker> {
  Color pickerColor;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return StoreConnector<AppState, IconColorPickerViewModel>(
      converter: IconColorPickerViewModel.fromStore,
      builder: (BuildContext context, IconColorPickerViewModel viewModel) {
        return Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                height: 80.0,
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: BottomBarBuilder.build(
                  BottomBarType.example,
                  selectedColor: pickerColor,
                ),
              ),
              SizedBox(height: 40.0),
              CircleColorPicker(
                initialColor: theme.colors.iconColor,
                strokeWidth: 15.0,
                onChanged: changeColor,
                textStyle: theme.textStyles.primaryTextStyle(size: 20.0),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: GlobalButton(
                        text: 'Cancel',
                        onTap: viewModel.pop,
                        bgColor: theme.colors.accentColor,
                        borderColor: theme.colors.inActiveColor,
                      ),
                    ),
                    Expanded(
                      child: GlobalButton(
                        text: 'Set',
                        onTap: () {
                          viewModel.chooseActiveColor(pickerColor, ColorType.icon);
                          viewModel.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}
