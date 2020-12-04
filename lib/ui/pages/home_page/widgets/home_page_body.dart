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
  Function _toggleGridAnimation = () {};
  bool wasButtonTapped = false;
  bool areCardsExpanded = false;
  bool areBigLikesVisible = false;

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
                      onTap: _changeView,
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
                  childrenAspectRatio: 6 / 5,
                  allSideChildrenPadding: 8.0,
                  gridRowsCount: imageCards.length,
                  duration: const Duration(milliseconds: 1200),
                  toggleAnimationCallback: (Function toggleAnimation) => _toggleGridAnimation = toggleAnimation,
                  autoDimensionsBuilder: (double height, double width, int index) {
                    return GridImageItem(
                      height: height,
                      padding: const EdgeInsets.all(12.0),
                      onTap: () {
                        viewModel.selectImage(imageCards[index]);
                        viewModel.navigateTo(kRouteInfoImageInfoPage);
                      },
                      card: imageCards[index],
                      isExpanded: areCardsExpanded,
                      isBigLikeVisible: areBigLikesVisible,
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

  void _changeView() {
    wasButtonTapped = true;

    if (!areCardsExpanded) {
      _toggleGridAnimation();
      _delay(milliseconds: 700, function: _swapCardBool);

    } else {
      _swapCardBool();
      _delay(milliseconds: 100, function: _toggleGridAnimation);
    }

    _delay(milliseconds: 1400, function: () => wasButtonTapped = false);
    setState(() {});
  }

  void _swapCardBool() {
    areCardsExpanded = !areCardsExpanded;
    areBigLikesVisible = !areBigLikesVisible;
  }

  void _delay({Function function, int milliseconds}) {
    Future.delayed(Duration(milliseconds: milliseconds), () {
      function();
      setState(() {});
    });
  }
}
