import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/app_styles/app_shadows.dart';

import 'package:pictures_view/ui/layouts/bottom_bar/bottom_bar_view_model.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_builder.dart';

class BottomBar extends ThemeStatelessWidget {
  static const String tag = 'BottomBar';
  static final GlobalKey bottomBarKey = GlobalKey(debugLabel: 'Global' + tag);
  static const double _kBorderRadius = 15.0;

  final double height;

  BottomBar({
    this.height = 90.0,
  }) : super(key: Key(tag));

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector(
      converter: BottomBarViewModel.fromStore,
      builder: (BuildContext context, BottomBarViewModel viewModel) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          key: bottomBarKey,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          decoration: BoxDecoration(
            color: theme.colors.primaryColor,
            // border: Border.all(color: theme.colors.inActiveColor),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_kBorderRadius),
              topRight: Radius.circular(_kBorderRadius),
            ),
            boxShadow: AppShadows.bottomBarShadow,
          ),
          child: BottomBarBuilder.build(
            BottomBarType.general,
            navigateFunc: viewModel.navigateTo,
          ),
        );
      },
    );
  }
}
