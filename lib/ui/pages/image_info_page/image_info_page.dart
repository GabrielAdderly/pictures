import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/ui/layouts/appbars/empty_appbar.dart';
import 'package:pictures_view/ui/pages/image_info_page/image_info_view_model.dart';
import 'package:pictures_view/ui/pages/image_info_page/widgets/image_info_body.dart';

class ImageInfoPage extends PageWidget {
  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) => EmptyAppbar();

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Dictionary dictionary) {
    return StoreConnector<AppState, ImageInfoViewModel>(
      converter: ImageInfoViewModel.fromStore,
      builder: (BuildContext context, ImageInfoViewModel viewModel) {
        return ImageInfoBody(image: viewModel.image);
      },
    );
  }
}
