import 'package:flutter/material.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';

import 'package:pictures_view/dummy_classes/dummy_image_list.dart';
import 'package:pictures_view/dummy_classes/dummy_categories.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/grid_image_item.dart';

import 'package:pictures_view/ui/layouts/appbars/search_appbar.dart';

import 'package:pictures_view/ui/widgets/categories_list.dart';
import 'package:pictures_view/ui/widgets/image_card/image_card.dart';
import 'package:pictures_view/ui/widgets/builder_widgets/page_widget.dart';

class HomePage extends PageWidget {
  HomePage() : super(key: Key('HomePage'));

  final TextEditingController controller = TextEditingController();

  final List<CardDTO> imageCards = [for (int i = 0; i < 20; i++) ...dummyImageList];

  final List<CategoryDTO> _categories = dummyCategories;

  @override
  PreferredSizeWidget buildAppBar() {
    return SearchAppBar(
      title: 'IMAGE GALLERY',
      controller: controller,
      additionalAppBarElement: CategoriesList(
        key: Key('categories_list'),
        categories: _categories,
        selectCallback: (int index) {},
      ),
      additionalAppBarHeight: 36.0,
    );
  }

  @override
  Widget buildBody(BuildContext context, AVTheme theme, Language dictionary) {
    return Container(
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: CleanBehavior(),
        child: GridView.builder(
          key: Key('Grid'),
          itemCount: imageCards.length,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.86,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GridImageItem(
              aspectRatio: 1,
              child: ImageCard(
                key: Key('image_card_$index'),
                card: imageCards[index],
                onTap: () {},
                likeCallback: (bool isLiked) => imageCards[index].updateLikes(),
              ),
            );
          },
        ),
      ),
    );
  }
}
