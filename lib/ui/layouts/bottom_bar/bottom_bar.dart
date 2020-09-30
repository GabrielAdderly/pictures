import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/res/app_styles/app_shadows.dart';

import 'package:pictures_view/handler/route_handler.dart';

import 'package:pictures_view/models/models/bottom_bar_item_model.dart';

import 'package:pictures_view/ui/layouts/bottom_bar/bottom_bar_view_model.dart';
import 'package:pictures_view/ui/layouts/bottom_bar/widgets/bottom_bar_item.dart';
import 'package:pictures_view/ui/widgets/builder_widgets/theme_stateless_widget.dart';

class BottomBar extends ThemeStatelessWidget {
  static final GlobalKey bottomBarKey = GlobalKey(debugLabel: 'Bottom Bar');
  static const double _kBorderRadius = 25.0;

  final double height;

  BottomBar({
    this.height = 80.0,
  }) : super(key: Key('lalal'));

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return StoreConnector(
      converter: BottomBarViewModel.fromStore,
      builder: (BuildContext context, BottomBarViewModel viewModel) {
        return  Container(
          key: bottomBarKey,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          decoration: BoxDecoration(
            color: theme.colors.primaryColor,
            border: Border.all(width: 1.0, color: theme.colors.inActiveColor),
            borderRadius: BorderRadius.circular(_kBorderRadius),
            boxShadow: AppShadows.bottomBarShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: RouteHandler.instance.barItems.map((BottomBarItemModel bottomBarItemModel) {
              return BottomBarItem(
                onTap: () => viewModel.navigateTo(bottomBarItemModel.route),
                iconData: bottomBarItemModel.iconData,
                isSelected: bottomBarItemModel.isSelected,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}