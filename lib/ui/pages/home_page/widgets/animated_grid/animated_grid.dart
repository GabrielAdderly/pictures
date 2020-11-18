import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/dummy_classes/dummy_image_list.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/grid_image_item.dart';

import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/animated_grid_view_model.dart';
import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/widgets/list_column_builder.dart';

class AnimatedGrid extends ThemeStatefulWidget {
  final Function(Function toggleAnimation) toggleAnimationCallback;

  AnimatedGrid({
    this.toggleAnimationCallback,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedGridState();
}

class _AnimatedGridState extends ThemeState<AnimatedGrid> {
  final List<CardDTO> imageCards = [...dummyImageList];

  bool _isOpened = false;
  bool _areCardsExpanded = false;
  bool _areCardsMoved = false;
  bool _isBigLikeVisible = false;
  double cardHeight;
  double primaryHeight;
  double halfOfPrimaryWidth;
  double cardHeightWithPadding;

  @override
  void initState() {
    super.initState();
    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    primaryHeight = WidgetsBinding.instance.window.physicalSize.height / pixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;
    //6/5 - aspectRatio analog, since aspectRatio can't be used with animation widgets
    cardHeight = halfOfPrimaryWidth * 6/5;
    cardHeightWithPadding = cardHeight + 16.0;

    widget.toggleAnimationCallback(_toggleAnimation);
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, AnimatedGridViewModel>(
      converter: AnimatedGridViewModel.fromStore,
      builder: (BuildContext context, AnimatedGridViewModel viewModel) {
        return ScrollConfiguration(
          behavior: CleanBehavior(),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                ListColumnBuilder(
                  itemCount: imageCards.length,
                  builder: (int index) {
                    return _getEvenCard(index, viewModel);
                  },
                ),
                AnimatedPadding(
                  duration: const Duration(milliseconds: 250),
                  padding: _getUnevenListViewPadding,
                  child: ListColumnBuilder(
                    itemCount: imageCards.length,
                    builder: (int index) {
                      return _getUnevenCard(index, viewModel);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getEvenCard(int index, AnimatedGridViewModel viewModel) {
    if (index == 0) {
      return _gridItemFacade(
        index: index,
        padding: _areCardsExpanded ? EdgeInsets.zero : EdgeInsets.only(right: halfOfPrimaryWidth),
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

  Widget _getUnevenCard(int index, AnimatedGridViewModel viewModel) {
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
        onTap: onTap,
        card: imageCards[index],
        isExpanded: _areCardsExpanded,
        isBigLikeVisible: _isBigLikeVisible,
      ),
    );
  }

  EdgeInsets get _getEvenCardPadding {
    if (_areCardsExpanded) return EdgeInsets.only(top: cardHeightWithPadding);
    if (_isOpened) return EdgeInsets.only(top: cardHeightWithPadding, right: halfOfPrimaryWidth);
    return EdgeInsets.only(right: halfOfPrimaryWidth);
  }

  EdgeInsets get _getUnevenCardPadding {
    if (_areCardsExpanded) return EdgeInsets.only(top: cardHeightWithPadding);
    if (_areCardsMoved) return EdgeInsets.only(top: cardHeightWithPadding);
    if (_isOpened) return EdgeInsets.only(top: cardHeightWithPadding);
    return EdgeInsets.zero;
  }

  EdgeInsets get _getUnevenListViewPadding {
    if (_areCardsExpanded) return EdgeInsets.zero;
    if (_areCardsMoved) return EdgeInsets.only(right: halfOfPrimaryWidth);
    if (_isOpened) return EdgeInsets.only(left: halfOfPrimaryWidth);
    return EdgeInsets.only(left: halfOfPrimaryWidth);
  }

  void _toggleAnimation() {
    if (!_isOpened) {
      //250ms duration. Adds vertical space between cards
      _isOpened = true;

      //50ms pause + 250ms previous animations
      //250ms duration. Moves cars horizontally
      Future.delayed(const Duration(milliseconds: 300), () {
        _areCardsMoved = !_areCardsMoved;
        setState(() {});
      });
      //100ms pause + 600ms previous animations&pauses
      //550ms duration. Expands cards and pictures
      Future.delayed(const Duration(milliseconds: 650), () {
        _areCardsExpanded = !_areCardsExpanded;
        setState(() {});
      });
      //1500ms previous animations. Stats before previous animation ends
      //400ms duration. Opaques in the like button
      Future.delayed(const Duration(milliseconds: 1400), () {
        _isBigLikeVisible = !_isBigLikeVisible;
        setState(() {});
      });
    } else {
      //550ms duration. Shrinks cards, like buttons and pictures
      _areCardsExpanded = !_areCardsExpanded;
      _isBigLikeVisible = !_isBigLikeVisible;
      //150ms pause + 550ms previous animations
      //250ms duration. Moves cars horizontally
      Future.delayed(const Duration(milliseconds: 700), () {
        _areCardsMoved = !_areCardsMoved;
        setState(() {});
      });
      //50ms pause + 950ms previous animations
      //250ms duration. Shrinks adds vertical space between cards
      Future.delayed(const Duration(milliseconds: 1000), () {
        _isOpened = false;
        setState(() {});
      });
    }
    setState(() {});
  }
}
