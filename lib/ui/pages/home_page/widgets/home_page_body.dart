import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/pic_main_lib.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/dummy_classes/dummy_lib.dart';
import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/animated_grid.dart';

import 'package:pictures_view/ui/pages/home_page/home_page_view_model.dart';
import 'package:pictures_view/widgets/custom_icon_view/icon_view_widget.dart';

import 'package:pictures_view/ui/widgets/categories_list.dart';
import 'package:pictures_view/widgets/grid_image_item.dart';

class HomePageBody extends ThemeStatefulWidget {
  HomePageBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends ThemeState {
  final List<CategoryDTO> _categories = dummyCategories;
  final List<CardDTO> imageCards = [...dummyImageList];
  Function _toggleAnimation = () {};
  bool wasButtonTapped = false;


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
                            theme.colors.accentColor.withOpacity(0),
                            theme.colors.accentColor,
                          ],
                          stops: [0.0, 0.6],
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: wasButtonTapped,
                    child: IconViewWidget(
                      onTap: () {
                        wasButtonTapped = true;
                        _toggleAnimation();
                        Future.delayed(const Duration(milliseconds: 1400), () {
                          wasButtonTapped = false;
                          setState(() {});
                        });
                        setState(() {});
                      },
                      size: 44.0,
                      color: theme.colors.accentColor.withOpacity(0.2),
                      bgColor: theme.colors.accentColor,
                      strokeColor: theme.colors.iconColor,
                      strokeWidth: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 90.0),
                child: AnimatedGrid(
                  childrenAspectRatio: 6/5,
                  allSideChildrenPadding: 8.0,
                  gridRowsCount: imageCards.length,
                  duration: const Duration(milliseconds: 300),
                  toggleAnimationCallback: (Function toggleAnimation) => _toggleAnimation = toggleAnimation,
                  autoDimensionsBuilder: (double height, double width, int index) {
                    return GridImageItem(
                      height: height,
                      onTap: () {
                        viewModel.selectImage(imageCards[index]);
                        viewModel.navigateTo(kRouteInfoImageInfoPage);
                      },
                      card: imageCards[index],
                    );
                      //return Container(color: Colors.red, height: height, width: width,);
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
