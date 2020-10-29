import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/ui/layouts/appbars/search_appbar.dart';
import 'package:pictures_view/ui/pages/home_page/widgets/home_page_body.dart';

class HomePage extends PageWidget {
  HomePage() : super(key: Key('HomePage'));

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) => SearchAppBar(title: 'IMAGE GALLERY');

  @override
  Widget buildBody(BuildContext context, CustomTheme theme, Dictionary dictionary) => HomePageBody();
}
