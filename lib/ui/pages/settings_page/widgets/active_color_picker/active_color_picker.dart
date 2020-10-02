import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/active_color_picker/active_color_pick_element.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/active_color_picker/active_color_picker_view_model.dart';

class ActiveColorPicker extends ThemeStatelessWidget {
  const ActiveColorPicker({Key key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return StoreConnector<AppState, ActiveColorPickerViewModel>(
      converter: ActiveColorPickerViewModel.fromStore,
      builder: (BuildContext context, ActiveColorPickerViewModel viewModel) {
        return Row(
          children: CustomTheme.mainActiveColors.map((Color activeColor) {
            return ActiveColorPickElement(
              key: Key('color_picker_${activeColor.toString()}'),
              isSelected: CustomTheme.isActiveColor(activeColor),
              color: activeColor,
              chooseActiveColor: viewModel.chooseActiveColor,
            );
          }).toList(),
        );
      },
    );
  }
}
