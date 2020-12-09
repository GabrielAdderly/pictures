import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/dummy_classes/dummy_lib.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/grid_image_item.dart';
import 'package:pictures_view/ui/pages/home_page/home_page_view_model.dart';
import 'package:pictures_view/widgets/custom_icon_view/icon_view_widget.dart';

import 'package:pictures_view/ui/widgets/categories_list.dart';

class HomePageBody extends ThemeStatefulWidget {
  HomePageBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends ThemeState {
  final List<CategoryDTO> _categories = dummyCategories;
  final List<CardDTO> imageCards = [...dummyImageList];
  bool isOpened = false;

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, HomePageViewModel>(
      converter: HomePageViewModel.fromStore,
      builder: (BuildContext context, HomePageViewModel viewModel) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  CategoriesList(
                    key: Key('categories_list'),
                    categories: _categories,
                    selectCallback: (int index) {},
                  ),
                  IgnorePointer(
                    child: Container(
                      height: 36.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colors.accentColor.withOpacity(0.0),
                            theme.colors.accentColor,
                          ],
                          stops: [0.0, 0.6],
                        ),
                      ),
                      child: SizedBox(),
                    ),
                  ),
                  IconViewWidget(
                    onTap: () {
                      isOpened = !isOpened;
                      setState(() {});
                    },
                    size: 44.0,
                    color: theme.colors.accentColor.withOpacity(0.2),
                    bgColor: theme.colors.accentColor,
                    strokeColor: theme.colors.iconColor,
                    strokeWidth: 2.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: CleanBehavior(),
                child: GridView.builder(
                  shrinkWrap: true,
                  key: Key('Grid'),
                  itemCount: imageCards.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isOpened ? 1 : 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GridImageItem(
                      aspectRatio: 1,
                      onTap: () {
                        viewModel.selectImage(imageCards[index]);
                        viewModel.navigateTo(kRouteInfoImageInfoPage);
                      },
                      card: imageCards[index],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
