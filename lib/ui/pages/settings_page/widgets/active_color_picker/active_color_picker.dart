import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/active_color_picker/active_color_pick_element.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/active_color_picker/active_color_picker_view_model.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/custom_color_picker_button.dart';
import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

class ActiveColorPicker extends ThemeStatelessWidget {
  const ActiveColorPicker({Key key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, ActiveColorPickerViewModel>(
      converter: ActiveColorPickerViewModel.fromStore,
      builder: (BuildContext context, ActiveColorPickerViewModel viewModel) {
        return CleanedScrollView(
          scrollDirection: Axis.horizontal,
          children: ThemeService.mainActiveColors.map<Widget>((Color activeColor) {
            return ActiveColorPickElement(
              key: Key('color_picker_${activeColor.toString()}'),
              isSelected: ThemeService.isActiveColor(activeColor),
              color: activeColor,
              chooseActiveColor: viewModel.chooseActiveColor,
            );
          }).toList()
            ..insert(
              0,
              CustomColorPickerButton(
                key: Key('meowmoew'),
                onTap: () => viewModel.navigateTo(ROUTE_INFO_CUSTOM_COLOR_PICKER_PAGE),
              ),
            ),
        );
      },
    );
  }
}
