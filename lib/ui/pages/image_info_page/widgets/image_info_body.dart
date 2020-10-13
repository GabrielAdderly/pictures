import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/widgets/global_button.dart';

import 'package:pictures_view/ui/pages/image_info_page/widgets/image_content.dart';
import 'package:pictures_view/ui/layouts/appbars/transparent_appbar/transparent_appbar.dart';

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
  Animation<double> _animationPadding;
  Animation<double> _animationCard;
  Animation<double> _animationContainer;

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
      final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
      maxHeight = MediaQuery.of(context).size.height;
      minPadding = maxHeight * 0.3;
      maxPadding = maxHeight * 0.75;
      _animationPadding = Tween<double>(begin: maxPadding, end: minPadding).animate(curvedAnimation);
      _animationCard = Tween<double>(begin: maxPadding + 50.0, end: minPadding + 50.0).animate(curvedAnimation);
      _animationContainer = Tween<double>(begin: minPadding, end: maxPadding).animate(curvedAnimation);
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
          padding: EdgeInsets.only(top: _animationPadding?.value ?? 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: _animationContainer?.value ?? 0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colors.primaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: ImageContent(
                      isOpened: isOpened,
                      image: widget.image,
                      controller: controller,
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
        TransParentAppBar(isFavorite: widget.image.isLiked),
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
