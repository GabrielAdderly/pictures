import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/custom_color_picker/custom_color_picker_view_model.dart';

class CustomColorPicker extends ThemeStatelessWidget {
  CustomColorPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, CustomColorPickerViewModel>(
      converter: CustomColorPickerViewModel.fromStore,
      builder: (BuildContext context, CustomColorPickerViewModel viewModel) {
        return Center(
          child: InkWell(
            onTap: () => viewModel.navigateTo(kRouteInfoCustomColorPickerPage),
            child: Container(
              height: 50.0,
              width: 100.0,
              alignment: Alignment.center,
              color: theme.colors.primaryColor,
              child: Text(
                'tap tap',
                style: theme.textStyles.primaryTextStyle(),
              ),
            ),
          ),
        );
      },
    );
  }
}
