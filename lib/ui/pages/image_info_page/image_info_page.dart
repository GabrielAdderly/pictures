import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/widgets/cached_image.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';
import 'package:pictures_view/ui/pages/image_info_page/image_info_view_model.dart';

class ImageInfoPage extends PageWidget {
  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return MainAppBar(title: 'CURRENT IMAGE');
  }

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Dictionary dictionary) {
    return StoreConnector<AppState, ImageInfoViewModel>(
      converter: ImageInfoViewModel.fromStore,
      builder: (BuildContext context, ImageInfoViewModel viewModel) {
        return Center(
          child: CachedImage.squared(
            size: 300,
            fit: BoxFit.fitHeight,
            imageUrl: viewModel.image.imageUrl,
          ),
        );
      },
    );
  }
}
