import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/pages/settings_page/widgets/custom_theme_picker/custom_theme_element.dart';
import 'package:pictures_view/ui/pages/settings_page/widgets/custom_theme_picker/custom_theme_picker_view_model.dart';

class CustomThemePicker extends ThemeStatelessWidget {

  const CustomThemePicker({Key key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, CustomThemePickerViewModel>(
      converter: CustomThemePickerViewModel.fromStore,
      builder: (BuildContext context, CustomThemePickerViewModel viewModel) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          color: theme.colors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6.0),
          child: Row(
            children: ThemeService.mainThemes.map((CustomTheme customTheme) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: InkWell(
                  onTap: () => viewModel.chooseTheme(customTheme),
                  child: Column(
                    children: <Widget>[
                      CustomThemeElement(customTheme: customTheme),
                      const SizedBox(height: 10.0),
                      Text(
                        customTheme.themeName,
                        style: theme.textStyles.primaryTextStyle(size: 16.0, height: 1.2),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
