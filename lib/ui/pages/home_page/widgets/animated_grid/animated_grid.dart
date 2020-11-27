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

class _AnimatedGridState extends ThemeState<AnimatedGrid> with TickerProviderStateMixin {
  final List<CardDTO> imageCards = [...dummyImageList];

  bool _areCardsExpanded = false;
  bool _isBigLikeVisible = false;
  bool _isAnimatedForward = true;
  double cardHeight;
  double primaryHeight;
  double halfOfPrimaryWidth;
  double cardHeightWithPadding;
  int scrollMultiplier = 0;
  int listScrollMultiplier = 0;
  double savedStartOffset = 0.0;
  double savedFinalOffset = 0.0;
  //double scrollDifference = 0.0;
  final ScrollController _scrollController = ScrollController();
  AnimationController topPaddingController;
  AnimationController rightEvenPaddingController;
  AnimationController leftUnevenPaddingController;
  AnimationController rightUnevenPaddingController;
  Animation animateTopPadding;
  Animation animateEvenRightPadding;
  Animation animateUnevenLeftPadding;
  Animation animateUnevenRightPadding;

  @override
  void initState() {
    super.initState();
    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    primaryHeight = WidgetsBinding.instance.window.physicalSize.height / pixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;
    //6/5 - aspectRatio analog, since aspectRatio can't be used with animation widgets
    cardHeight = halfOfPrimaryWidth * 6 / 5;
    cardHeightWithPadding = cardHeight + 16.0;

    widget.toggleAnimationCallback(_toggleAnimation);

    topPaddingController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    rightEvenPaddingController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    leftUnevenPaddingController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    rightUnevenPaddingController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);

    _initTopPaddingAnimation;
    _initUnevenLeftPaddingAnimation;
    _initUnevenRightPaddingAnimation;
    _initEvenRightPaddingAnimation;
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return StoreConnector<AppState, AnimatedGridViewModel>(
      converter: AnimatedGridViewModel.fromStore,
      builder: (BuildContext context, AnimatedGridViewModel viewModel) {
        return ScrollConfiguration(
          behavior: CleanBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                ListColumnBuilder(
                  itemCount: imageCards.length,
                  builder: (int index) {
                    return _getEvenCard(index, viewModel);
                  },
                ),
                ListColumnBuilder(
                  itemCount: imageCards.length,
                  builder: (int index) {
                    return _getUnevenCard(index, viewModel);
                  },
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
        padding: EdgeInsets.only(right: animateEvenRightPadding.value),
        onTap: () {
          viewModel.selectImage(imageCards[index]);
          viewModel.navigateTo(kRouteInfoImageInfoPage);
        },
      );
    }
    if (index % 2 == 0) {
      return _gridItemFacade(
        index: index,
        padding: EdgeInsets.only(top: animateTopPadding.value, right: animateEvenRightPadding.value),
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
        padding: EdgeInsets.only(
          top: animateTopPadding.value,
          left: animateUnevenLeftPadding.value,
          right: animateUnevenRightPadding.value,
        ),
        onTap: () {
          viewModel.selectImage(imageCards[index]);
          viewModel.navigateTo(kRouteInfoImageInfoPage);
        },
      );
    }
    return const SizedBox();
  }

  Widget _gridItemFacade({int index, Function onTap, EdgeInsets padding = EdgeInsets.zero}) {
    return Padding(
      padding: padding,
      child: GridImageItem(
        height: cardHeight,
        onTap: onTap,
        card: imageCards[index],
        isExpanded: _areCardsExpanded,
        isBigLikeVisible: _isBigLikeVisible,
      ),
    );
  }

  void _toggleAnimation() {
    if (topPaddingController.value == 0.0) {
      topPaddingController.forward();
      print('${_scrollController.offset}');
    } else {
      _isAnimatedForward = false;
      rightEvenPaddingController.reverse();
      rightUnevenPaddingController.forward();
    }
  }

  void get _initTopPaddingAnimation {
    AnimationStatus animationStatus;
    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)
      ..addListener(() {
        if (animationStatus == null) _animateScrollController();
        if (animationStatus == AnimationStatus.forward) {
          print('FORWARD');
          _animateScrollController();
        }
        if (animationStatus == AnimationStatus.reverse) {
          print('REVERSE');
          _animateScrollController(reversed: true);
        }
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        animationStatus = status;
        if (status == AnimationStatus.completed) {
          leftUnevenPaddingController.forward();
          rightUnevenPaddingController.forward();
        } else if (status == AnimationStatus.dismissed) {
          print('DONE');
          print('jump offset ${savedFinalOffset + animateTopPadding.value * listScrollMultiplier}');
          _isAnimatedForward = true;
          _initBufferVariables();
        }
      });
  }

  void get _initUnevenLeftPaddingAnimation {
    animateUnevenLeftPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(leftUnevenPaddingController);
  }

  void get _initUnevenRightPaddingAnimation {
    animateUnevenRightPadding = Tween<double>(begin: 0, end: halfOfPrimaryWidth).animate(rightUnevenPaddingController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed && _isAnimatedForward) {
          rightEvenPaddingController.forward();
          rightUnevenPaddingController.reverse();
        } else if (status == AnimationStatus.dismissed && !_isAnimatedForward) topPaddingController.reverse();
      });
  }

  void get _initEvenRightPaddingAnimation {
    animateEvenRightPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(rightEvenPaddingController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          print('CLEARED');
          print('saved list offset $savedFinalOffset');
          print('offset ${_scrollController.offset}');
          print('jump offset ${savedFinalOffset + animateTopPadding.value * listScrollMultiplier}');
          print('tween ${animateTopPadding.value}');
          print('scrollMultiplier $scrollMultiplier');
          _initBufferVariables();
        }
        if (status == AnimationStatus.dismissed && !_isAnimatedForward) {
          leftUnevenPaddingController.reverse();
          rightUnevenPaddingController.reverse();
        }
      });
  }

  void _animateScrollController({bool reversed = false}) {
    if (scrollMultiplier == 0) scrollMultiplier = _scrollController.offset ~/ cardHeightWithPadding;
    if (savedStartOffset == 0.0) savedStartOffset = _scrollController.offset;
    //if (scrollDifference == 0.0) scrollDifference = savedStartOffset % cardHeightWithPadding;
    if (reversed && savedFinalOffset == 0.0) savedFinalOffset = _scrollController.offset / 2;
    if (reversed && listScrollMultiplier == 0) listScrollMultiplier = _scrollController.offset / 2 ~/ cardHeightWithPadding;

    //print('savedOffset $savedStartOffset');
    print('saved list offset $savedFinalOffset');
    print('offset ${_scrollController.offset}');
    print('jump offset ${savedFinalOffset + animateTopPadding.value * listScrollMultiplier}');
    print('tween ${animateTopPadding.value}');
    print('scrollMultiplier $scrollMultiplier');

    _scrollController.jumpTo(
      reversed
          ? savedFinalOffset + animateTopPadding.value * listScrollMultiplier
          : savedStartOffset + animateTopPadding.value * scrollMultiplier,
    );
  }

  void _initBufferVariables() {
    scrollMultiplier = 0;
    savedStartOffset = 0.0;
    savedFinalOffset = 0.0;
    listScrollMultiplier = 0;
  }
}
