import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/widgets/divider.dart';
import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/widgets/global_button.dart';

class ImageInfoBody extends ThemeStatefulWidget {
  final CardDTO image;

  ImageInfoBody({
    @required this.image,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageInfoBodyState();
}

class ImageInfoBodyState extends ThemeState<ImageInfoBody> with SingleTickerProviderStateMixin {
  ScrollController controller;
  double topPadding = 0;
  double minPadding;
  double maxPadding;
  double maxHeight;
  bool isOpened = false;
  PhotoViewScaleStateController scaleStateController;

  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _animationCard;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    scaleStateController = PhotoViewScaleStateController();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: kBaseChangeDuration,
    )..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      maxHeight = MediaQuery.of(context).size.height;
      minPadding = maxHeight * 0.3;
      maxPadding = maxHeight * 0.75;
      _animation = Tween<double>(begin: maxPadding, end: minPadding).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
      _animationCard = Tween<double>(begin: maxPadding + 50.0, end: minPadding + 50.0)
          .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: _animationCard?.value ?? 0,
          child: PhotoView(
            imageProvider: NetworkImage(widget.image.imageUrl),
            basePosition: Alignment.topCenter,
            minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
            scaleStateController: scaleStateController,
            backgroundDecoration: BoxDecoration(color: theme.colors.accentColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: _animation?.value ?? 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colors.primaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: SingleChildScrollView(
                      controller: controller,
                      physics: isOpened ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 40.0),
                          Text(
                            widget.image.title,
                            style: theme.textStyles.primaryTextStyle(size: 30.0),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 1500),
                            opacity: isOpened ? 1 : 0,
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 20.0),
                                AppDivider(margin: EdgeInsets.symmetric(horizontal: 60.0)),
                                const SizedBox(height: 14.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    widget.image.content,
                                    style: theme.textStyles.w400TextStyle(size: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 150.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.kTransparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: GlobalButton(
                          text: 'Overview',
                          onTap: changePosition,
                          bgColor: theme.colors.buttonColor,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void changePosition() {
    isOpened = !isOpened;
    if (isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    scaleStateController.reset();
    setState(() {});
  }
}
