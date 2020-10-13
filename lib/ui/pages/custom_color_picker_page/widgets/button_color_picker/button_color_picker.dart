import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/widgets/global_button.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/pages/custom_color_picker_page/widgets/button_color_picker/button_color_picker_view_model.dart';

class ButtonColorPicker extends ThemeStatefulWidget {
  ButtonColorPicker({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonColorPickerState();
}

class _ButtonColorPickerState extends ThemeState<ButtonColorPicker> {
  Color pickerColor;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, ButtonColorPickerViewModel>(
      converter: ButtonColorPickerViewModel.fromStore,
      builder: (BuildContext context, ButtonColorPickerViewModel viewModel) {
        getStartColor(theme);
        return Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                height: 80.0,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: GlobalButton(
                        text: 'Details',
                        onTap: () {},
                        bgColor: pickerColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              CircleColorPicker(
                initialColor: theme.colors.buttonColor,
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
                          viewModel.chooseActiveColor(pickerColor, ColorType.button);
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

  void getStartColor (CustomTheme theme) {
    if (pickerColor == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        pickerColor = theme.colors.buttonColor;
        setState(() {});
      });
    }
  }
}
