import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';

import 'package:pictures_view/dummy_classes/dummy_lib.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/ui/pages/home_page/home_page_view_model.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/grid_image_item.dart';

import 'package:pictures_view/ui/widgets/categories_list.dart';
import 'package:pictures_view/ui/layouts/appbars/search_appbar.dart';

class HomePage extends PageWidget {
  HomePage() : super(key: Key('HomePage'));

  final List<CardDTO> imageCards = [...dummyImageList];

  final List<CategoryDTO> _categories = dummyCategories;

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return SearchAppBar(
      title: 'IMAGE GALLERY',
      additionalAppBarElement: CategoriesList(
        key: Key('categories_list'),
        categories: _categories,
        selectCallback: (int index) {},
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Dictionary dictionary) {

    return StoreConnector<AppState, HomePageViewModel>(
      converter: HomePageViewModel.fromStore,
      builder: (BuildContext context, HomePageViewModel viewModel) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 90.0),
          child: ScrollConfiguration(
            behavior: CleanBehavior(),
            child: GridView.builder(
              key: Key('Grid'),
              itemCount: imageCards.length,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GridImageItem(
                  aspectRatio: 1,
                  onTap: () {
                    viewModel.selectImage(imageCards[index]);
                    viewModel.navigateTo(ROUTE_INFO_IMAGE_INFO_PAGE);
                  },
                  card: imageCards[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}