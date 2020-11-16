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
  bool _isOpened = false;
  bool _areCardsExpanded = false;
  bool _areCardsMoved = false;
  bool _isBigLikeVisible = false;
  double cardHeight;
  double primaryHeight;
  double primaryWidth;

  @override
  void initState() {
    super.initState();
    primaryHeight = WidgetsBinding.instance.window.physicalSize.height;
    primaryWidth = WidgetsBinding.instance.window.physicalSize.width;
    cardHeight = primaryHeight * 0.28;
  }

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
                  IconViewWidget(
                    onTap: _toggleAnimation,
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
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 90.0),
                child: ScrollConfiguration(
                  behavior: CleanBehavior(),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0.0),
                          itemCount: imageCards.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _getEvenCard(index, viewModel);
                          },
                        ),
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 250),
                          padding: _getUnevenListViewPadding,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0.0),
                            itemCount: imageCards.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _getUnevenCard(index, viewModel);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getEvenCard(int index, HomePageViewModel viewModel) {
    if (index == 0) {
      return _gridItemFacade(
        index: index,
        padding: _areCardsExpanded ? EdgeInsets.zero : EdgeInsets.only(right: primaryWidth * 0.5),
        onTap: () {
          viewModel.selectImage(imageCards[index]);
          viewModel.navigateTo(kRouteInfoImageInfoPage);
        },
      );
    }
    if (index % 2 == 0) {
      return _gridItemFacade(
        index: index,
        padding: _getEvenCardPadding,
        onTap: () {
          viewModel.selectImage(imageCards[index]);
          viewModel.navigateTo(kRouteInfoImageInfoPage);
        },
      );
    }
    return const SizedBox();
  }

  Widget _getUnevenCard(int index, HomePageViewModel viewModel) {
    if (index % 2 != 0) {
      return _gridItemFacade(
        index: index,
        padding: _getUnevenCardPadding,
        onTap: () {
          viewModel.selectImage(imageCards[index]);
          viewModel.navigateTo(kRouteInfoImageInfoPage);
        },
      );
    }
    return const SizedBox();
  }

  Widget _gridItemFacade({int index, Function onTap, EdgeInsets padding}) {
    return AnimatedPadding(
      padding: padding,
      duration: const Duration(milliseconds: 250),
      child: GridImageItem(
        height: cardHeight,
        width: primaryWidth * 0.5,
        onTap: onTap,
        card: imageCards[index],
        isExpanded: _areCardsExpanded,
        isBigLikeVisible: _isBigLikeVisible,
      ),
    );
  }

  EdgeInsets get _getEvenCardPadding {
    if (_areCardsExpanded) return EdgeInsets.only(top: cardHeight + 16.0);
    if (_isOpened) return EdgeInsets.only(top: cardHeight + 16.0, right: primaryWidth * 0.5);
    return EdgeInsets.only(right: primaryWidth * 0.5);
  }

  EdgeInsets get _getUnevenCardPadding {
    if (_areCardsExpanded) return EdgeInsets.only(top: cardHeight + 16.0);
    if (_areCardsMoved) return EdgeInsets.only(top: cardHeight + 16.0);
    if (_isOpened) return EdgeInsets.only(top: cardHeight + 16.0);
    return EdgeInsets.zero;
  }

  EdgeInsets get _getUnevenListViewPadding {
    if (_areCardsExpanded) return EdgeInsets.zero;
    if (_areCardsMoved) return EdgeInsets.only(right: primaryWidth * 0.5);
    if (_isOpened) return EdgeInsets.only(left: primaryWidth * 0.5);
    return EdgeInsets.only(left: primaryWidth * 0.5);
  }

  void _toggleAnimation() {
    if (!_isOpened) {
      //250ms. Adds vertical space between cards
      _isOpened = true;

      //50ms pause + 250ms previous animation
      //200ms duration. Moves cars horizontally
      Future.delayed(const Duration(milliseconds: 300), () {
        _areCardsMoved = !_areCardsMoved;
        setState(() {});
      });
      //100ms pause + 500ms previous animations&pauses
      //650ms duration. Expands cards and pictures
      Future.delayed(const Duration(milliseconds: 650), () {
        _areCardsExpanded = !_areCardsExpanded;
        setState(() {});
      });

      Future.delayed(const Duration(milliseconds: 1400), () {
        _isBigLikeVisible = !_isBigLikeVisible;
        setState(() {});
      });

    } else {
      _areCardsExpanded = !_areCardsExpanded;
      _isBigLikeVisible = !_isBigLikeVisible;

      Future.delayed(const Duration(milliseconds: 700), () {
        _areCardsMoved = !_areCardsMoved;
        setState(() {});
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        _isOpened = false;
        setState(() {});
      });
    }
    setState(() {});
  }
}
