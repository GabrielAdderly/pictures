import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/ui/pages/home_page/mixins/init_animations_mixin.dart';

import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/widgets/list_column_builder.dart';

/// !Works fine at version 1.22.0!
/// [duration] Full animation sequence duration
/// [crossAxisCount] Analog of crossAxisCount param from [GridView.count]
/// [showScrollDebugPrints] Shows all the Scroll internal info using [print]
/// [childrenAspectRatio] Analog of [AspectRatio], but applies as parameter
/// This param is a total necessity since Grid is responsive and auto-sized
/// Grid DOES NOT supports fixed widget sizes
/// Is the only way to size child widgets in the Grid
/// [allAxisChildrenPadding] Simply adds [Padding] between child widgets on both axis
/// [toggleAnimationCallback] Callback to pass the Function that forwards/reverses the animation sequence
/// [autoDimensionsBuilder] Callback to pass generated sizes and index into a parent widget
/// Also receives a Widget to be built in the Grid
class AnimatedGrid extends ThemeStatefulWidget {
  final Duration duration;
  final int crossAxisCount;
  final bool showScrollDebugPrints;
  final double childrenAspectRatio;
  final double allAxisChildrenPadding;
  final Function(Function toggleAnimation) toggleAnimationCallback;
  final Widget Function(double height, double width, int index) autoDimensionsBuilder;

  AnimatedGrid({
    @required this.duration,
    @required this.crossAxisCount,
    @required this.childrenAspectRatio,
    @required this.autoDimensionsBuilder,
    @required this.allAxisChildrenPadding,
    @required this.toggleAnimationCallback,
    this.showScrollDebugPrints = false,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedGridState();
}

class _AnimatedGridState extends ThemeState<AnimatedGrid> with TickerProviderStateMixin, InitAnimationMixin {

  /// [duration] is placed in [InitAnimationMixin] and takes value from [widget.duration]
  /// [showDebugPrints] is placed in [InitAnimationMixin] and takes value from [widget.showDebugPrints]
  /// [stepDuration] is a [widget.duration] divided by four
  /// Since the animation sequence consists of four animations with equal Duration
  /// [pixelRatio] is needed to calculate logical size from physical size
  /// [halfOfPrimaryWidth] equals the width of screen divided by two
  /// [cardHeightWithPadding] equals the size of the card and it's vertical padding
  /// [widget.toggleAnimationCallback] passes [_toggleAnimation] to the parent class
  @override
  void initState() {
    super.initState();

    showDebugPrints = widget.showScrollDebugPrints;

    duration = widget.duration;
    final Duration stepDuration = Duration(milliseconds: (widget.duration.inMilliseconds / 4).round());

    //region [Sizes calculation]
    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;
    cardHeightWithPadding = halfOfPrimaryWidth * widget.childrenAspectRatio + widget.allAxisChildrenPadding * 2;
    //endregion

    widget.toggleAnimationCallback(_toggleAnimation);

    //region [Controller and Animation initialization]
    topPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightEvenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    leftUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);
    rightUnevenPaddingController = AnimationController(duration: stepDuration, vsync: this);

    initTopPaddingAnimation();
    initUnevenLeftPaddingAnimation();
    initUnevenRightPaddingAnimation();
    initEvenRightPaddingAnimation();
    //endregion
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return CleanedScrollView(
      controller: scrollController,
      children: [
        Stack(
          children: [
            ListColumnBuilder(
              itemCount: widget.crossAxisCount,
              builder: (int index) {
                return _getEvenWidget(index);
              },
            ),
            ListColumnBuilder(
              itemCount: widget.crossAxisCount,
              builder: (int index) {
                return _getUnevenWidget(index);
              },
            ),
          ],
        ),
      ],
    );
  }

  /// [_getEvenWidget] that separates the even cards and the first(zero) card
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

  /// [_getUnevenWidget] separates the uneven cards
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

  /// [_gridItemFacade] receives widget from [autoDimensionsBuilder]
  /// Adds additional properties to the widget, gets the margins from [Tween]
  Widget _gridItemFacade({int index, EdgeInsets margin = EdgeInsets.zero}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(widget.allAxisChildrenPadding),
      child: widget.autoDimensionsBuilder(
          cardHeightWithPadding - widget.allAxisChildrenPadding * 2, double.infinity, index),
    );
  }

  /// [_toggleAnimation] triggers all the animation sequence
  void _toggleAnimation() {
    if (topPaddingController.value == 0.0) {
      topPaddingController.forward();
    } else {
      isAnimatedForward = false;
      unevenScroll(() {
        rightEvenPaddingController.reverse();
        rightUnevenPaddingController.forward();
      });
    }
  }
}
