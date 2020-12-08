import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/ui/pages/home_page/mixins/init_animations_mixin.dart';

import 'package:pictures_view/widgets/cleaned_scroll_view.dart';

import 'package:pictures_view/ui/pages/home_page/widgets/animated_grid/widgets/list_column_builder.dart';

/// !Works fine at version 1.22.0!
class AnimatedGrid extends ThemeStatefulWidget {
  ///Full animation sequence [Duration]
  final Duration duration;
  ///Analog of crossAxisCount param from [GridView.count]
  final int crossAxisCount;
  ///Shows all the Scroll internal info using [print]
  final bool showScrollDebugPrints;
  ///Analog of [AspectRatio], but applied automatically to Grid children
  ///This param is a total necessity since Grid is responsive and auto-sized
  ///Grid DOES NOT supports fixed widget sizes
  ///Thus [childrenAspectRatio] is only way to size child widgets in the Grid
  final double childrenAspectRatio;
  ///Simply adds [Padding] between child widgets on both axis
  final double allAxisChildrenPadding;
  ///Callback to pass the Function that forwards/reverses the animation sequence into a parent widget
  final Function(Function toggleAnimation) toggleAnimationCallback;
  ///Callback to pass generated sizes and index into a parent widget
  ///Also receives a Widget to be built in the Grid
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

///State contains functions that divide each column's widgets from each other to animate them
///Also contains some init functions since I haven't found a way to fully split them for now <3
///And also a Function that toggles the animation sequence
class _AnimatedGridState extends ThemeState<AnimatedGrid> with TickerProviderStateMixin, InitAnimationMixin {

  @override
  void initState() {
    super.initState();
    ///Passes values to mixin since I haven't found a way to use widget.variable in a mixin
    ///Don't punch me in the face
    duration = widget.duration;
    wasChecked = widget.showScrollDebugPrints;

    ///Duration is divided by four since the animation sequence consists of four animations with equal Duration
    final Duration stepDuration = Duration(milliseconds: (widget.duration.inMilliseconds / 4).round());

    //region [Sizes calculation]

    ///MediaQuery can't be used in initState without the addPostFrameCallback, so I found a nice workaround
    final double pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    halfOfPrimaryWidth = WidgetsBinding.instance.window.physicalSize.width / pixelRatio * 0.5;
    ///Calculates card height using card width
    ///Width is a static value since number of columns is fixed
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

  ///The function that divides the even cards
  Widget _getEvenWidget(int index) {
    ///Zero is not even, but still in the same column with even cards
    ///Still it's the other case since zero-widget shouldn't be animated vertically
    if (index == 0) {
      return _gridItemFacade(
        index: index,
        margin: EdgeInsets.only(right: animateEvenRightPadding.value),
      );
    }
    ///The case for even cards. Should be animated from top and right
    if (index % 2 == 0) {
      return _gridItemFacade(
        index: index,
        margin: EdgeInsets.only(top: animateTopPadding.value, right: animateEvenRightPadding.value),
      );
    }
    return const SizedBox();
  }

  ///The function that divides the uneven cards
  ///The case for uneven cards is the most complicated
  ///Should be animated from, top, right and left
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
      padding: EdgeInsets.all(widget.allAxisChildrenPadding),
      child: widget.autoDimensionsBuilder(
        cardHeightWithPadding - widget.allAxisChildrenPadding * 2,
        double.infinity,
        index,
      ),
    );
  }

  ///Function that triggers animation
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
