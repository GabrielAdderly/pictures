import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/widgets/favorite_button.dart';
import 'package:pictures_view/ui/layouts/appbars/transparent_appbar/transparent_view_model.dart';

class TransParentAppBar extends ThemeStatelessWidget implements PreferredSizeWidget {
  final bool isFavorite;
  final double height;
  @override
  final Size preferredSize;

  TransParentAppBar({
    @required this.isFavorite,
    this.height = 55.0,
    Key key,
  })  : preferredSize = Size.fromHeight(height),
        super(key: key);

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, TransparentAppBarViewModel>(
      converter: TransparentAppBarViewModel.fromStore,
      builder: (BuildContext context, TransparentAppBarViewModel viewModel) {
        return Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          color: AppColors.kTransparent,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: viewModel.pop,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                FavoriteButton(
                  size: 26.0,
                  isLiked: isFavorite,
                  likeCallback: (bool isLiked) {},
                  padding: const EdgeInsets.all(4.0),
                  inactiveColor: theme.colors.inActiveColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
