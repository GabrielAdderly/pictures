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

  @override
  void initState() {
    super.initState();

    duration = widget.duration;
    wasChecked = widget.showDebugPrints;
    final Duration stepDuration = Duration(milliseconds: (widget.duration.inMilliseconds / 4).round());

    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;
    cardHeightWithPadding = halfOfPrimaryWidth * widget.childrenAspectRatio + widget.allSideChildrenPadding * 2;

    widget.toggleAnimationCallback(_toggleAnimation);

    topPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightEvenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    leftUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);

    initTopPaddingAnimation();
    initUnevenLeftPaddingAnimation();
    initUnevenRightPaddingAnimation();
    initEvenRightPaddingAnimation();
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return CleanedScrollView(
      controller: scrollController,
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
      print('${scrollController.offset}');
    } else {
      isAnimatedForward = false;
      unevenScroll(() {
        rightEvenPaddingController.reverse();
        rightUnevenPaddingController.forward();
      });
    }
  }
}
