import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/ui/pages/home_page/mixins/init_animations_mixin.dart';

import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/widgets/list_column_builder.dart';

class AnimatedGrid extends ThemeStatefulWidget {
  final Duration duration;
  final int gridRowsCount;
  final bool showDebugPrints;
  final double childrenAspectRatio;
  final double allSideChildrenPadding;
  final Function(Function toggleAnimation) toggleAnimationCallback;
  final Widget Function(double height, double width, int index) autoDimensionsBuilder;

  AnimatedGrid({
    @required this.duration,
    @required this.gridRowsCount,
    @required this.childrenAspectRatio,
    @required this.autoDimensionsBuilder,
    @required this.toggleAnimationCallback,
    @required this.allSideChildrenPadding,
    this.showDebugPrints = false,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedGridState();
}

class _AnimatedGridState extends ThemeState<AnimatedGrid> with TickerProviderStateMixin, InitAnimationMixin {
  //bool _isAnimatedForward = true;
  //bool wasChecked = false;
  //double halfOfPrimaryWidth;
  double cardHeightWithPadding;
  int gridScrollMultiplier = 0;
  int listScrollMultiplier = 0;
  double savedGridOffset = 0.0;
  double savedListOffset = 0.0;
  double viewsScrollDifference = 0.0;
//  Animation animateTopPadding;
//  Animation animateEvenRightPadding;
//  Animation animateUnevenLeftPadding;
//  Animation animateUnevenRightPadding;
//  AnimationController topPaddingController;
//  AnimationController rightEvenPaddingController;
//  AnimationController leftUnevenPaddingController;
//  AnimationController rightUnevenPaddingController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;

    cardHeightWithPadding = halfOfPrimaryWidth * widget.childrenAspectRatio + widget.allSideChildrenPadding * 2;

    widget.toggleAnimationCallback(_toggleAnimation);

    final Duration stepDuration = Duration(milliseconds: (widget.duration.inMilliseconds / 4).round());

//    topPaddingController = AnimationController(duration: stepDuration, vsync: this);
//    rightEvenPaddingController = AnimationController(duration: stepDuration, vsync: this);
//    leftUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);
//    rightUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);
//
    initTopPaddingAnimation();
    _initUnevenLeftPaddingAnimation;
    _initUnevenRightPaddingAnimation;
    _initEvenRightPaddingAnimation;
  }



  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return CleanedScrollView(
      controller: _scrollController,
      children: [
        Stack(
          children: [
            ListColumnBuilder(
              itemCount: widget.gridRowsCount,
              builder: (int index) {
                return _getEvenWidget(index);
              },
            ),
            ListColumnBuilder(
              itemCount: widget.gridRowsCount,
              builder: (int index) {
                return _getUnevenWidget(index);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _getEvenWidget(int index) {
    if (index == 0) {
      return _gridItemFacade(
        index: index,
        margin: EdgeInsets.only(right: animateEvenRightPadding.value),
      );
    }
    if (index % 2 == 0) {
      return _gridItemFacade(
        index: index,
        margin: EdgeInsets.only(top: animateTopPadding.value, right: animateEvenRightPadding.value),
      );
    }
    return const SizedBox();
  }

  Widget _getUnevenWidget(int index) {
    if (index % 2 != 0) {
      return _gridItemFacade(
        index: index,
        margin: EdgeInsets.only(
          top: animateTopPadding.value,
          left: animateUnevenLeftPadding.value,
          right: animateUnevenRightPadding.value,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _gridItemFacade({int index, EdgeInsets margin = EdgeInsets.zero}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(widget.allSideChildrenPadding),
      child: widget.autoDimensionsBuilder(
        cardHeightWithPadding - widget.allSideChildrenPadding * 2,
        double.infinity,
        index,
      ),
    );
  }

  void _toggleAnimation() {
    if (topPaddingController.value == 0.0) {
      topPaddingController.forward();
      print('${_scrollController.offset}');
    } else {
      _isAnimatedForward = false;
      _unevenScroll(() {
        rightEvenPaddingController.reverse();
        rightUnevenPaddingController.forward();
      });
    }
  }

//  void get _initTopPaddingAnimation {
//    AnimationStatus animationStatus;
//    animateTopPadding = Tween<double>(begin: 0, end: cardHeightWithPadding).animate(topPaddingController)
//      ..addListener(() {
//        if (animationStatus == null) _compensateViewScrollChange();
//        if (animationStatus == AnimationStatus.forward) {
//          print('FORWARD');
//          _compensateViewScrollChange();
//        }
//        if (animationStatus == AnimationStatus.reverse && !_isAnimatedForward) {
//          _compensateViewScrollChange(reversed: true);
//        }
//        setState(() {});
//      })
//      ..addStatusListener((AnimationStatus status) {
//        animationStatus = status;
//        if (status == AnimationStatus.completed) {
//          leftUnevenPaddingController.forward();
//          rightUnevenPaddingController.forward();
//        } else if (status == AnimationStatus.dismissed) {
//          print('DONE');
//          wasChecked = false;
//          _isAnimatedForward = true;
//          _initBufferVariables();
//        }
//      });
//  }

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
        } else if (status == AnimationStatus.dismissed && !_isAnimatedForward) {
          print('REVERSE');
          topPaddingController.reverse();
        }
      });
  }

  void get _initEvenRightPaddingAnimation {
    animateEvenRightPadding = Tween<double>(begin: halfOfPrimaryWidth, end: 0).animate(rightEvenPaddingController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          print('DONE');
          _initBufferVariables();
        }
        if (status == AnimationStatus.dismissed && !_isAnimatedForward) {
          leftUnevenPaddingController.reverse();
          rightUnevenPaddingController.reverse();
        }
      });
  }

  void _compensateViewScrollChange({bool reversed = false}) {
    if (savedGridOffset == 0.0) savedGridOffset = _scrollController.offset;
    if (viewsScrollDifference == 0.0) viewsScrollDifference = savedGridOffset % cardHeightWithPadding;
    if (gridScrollMultiplier == 0) gridScrollMultiplier = _scrollController.offset ~/ cardHeightWithPadding;

    if (reversed) {
      if (savedListOffset == 0.0) {
        savedListOffset = (_scrollController.offset - viewsScrollDifference) / 2 + viewsScrollDifference;
      }
      if (listScrollMultiplier == 0) listScrollMultiplier = _scrollController.offset ~/ (2 * cardHeightWithPadding);

      _printDebug();
      _jumpTo(savedListOffset, listScrollMultiplier);
    } else {
      _printDebug();
      _jumpTo(savedGridOffset, gridScrollMultiplier);
    }
  }

  void _unevenScroll(Function triggerTween) {
    if (savedGridOffset == 0.0) savedGridOffset = _scrollController.offset;
    if (savedGridOffset ~/ cardHeightWithPadding % 2 != 0 && !wasChecked) {
      wasChecked = true;

      final Duration scrollToRowDuration = Duration(milliseconds: (widget.duration.inMilliseconds / 4).round());

      _scrollController.animateTo(
        savedGridOffset - cardHeightWithPadding,
        duration: scrollToRowDuration,
        curve: Curves.decelerate,
      );

      Future.delayed(scrollToRowDuration, () => triggerTween());
    } else {
      triggerTween();
    }
  }

  void _jumpTo(double offset, int offsetMultiplier) {
    _scrollController.jumpTo(offset + animateTopPadding.value * offsetMultiplier);
  }

  void _initBufferVariables() {
    savedGridOffset = 0.0;
    savedListOffset = 0.0;
    gridScrollMultiplier = 0;
    listScrollMultiplier = 0;
    viewsScrollDifference = 0.0;
  }

  void _printDebug() {
    if (widget.showDebugPrints) {
      print('Current offset ${_scrollController.offset}');
      print('Tween value ${animateTopPadding.value}');
      print('Views scroll difference $viewsScrollDifference');
      print('Saved list offset $savedListOffset');
      print('Saved grid offset $savedGridOffset');
      print('Current compensating jump offset ${savedListOffset + animateTopPadding.value * listScrollMultiplier}');
      print('Card height + padding $cardHeightWithPadding');
      print('List\'s compensating scroll multiplier $listScrollMultiplier');
      print('Grid\'s compensating scroll multiplier $gridScrollMultiplier');
    }
  }

  @override
  void updatePage() {
    setState(() {});
    super.updatePage();
  }
}
