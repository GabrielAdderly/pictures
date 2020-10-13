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
  bool isOpened = false;

  AnimationController _animationController;
  PhotoViewScaleStateController _scaleStateController;

  Animation<double> _paddingAnimation;
  Animation<double> _imageSizeAnimation;
  Animation<double> _containerSizeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleStateController = PhotoViewScaleStateController();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: kBaseChangeDuration,
    )..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback(bindingsInitAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: _imageSizeAnimation?.value ?? 0,
          child: PhotoView(
            imageProvider: NetworkImage(widget.image.imageUrl),
            basePosition: Alignment.topCenter,
            minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
            scaleStateController: _scaleStateController,
            backgroundDecoration: BoxDecoration(color: theme.colors.accentColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: _paddingAnimation?.value ?? 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: _containerSizeAnimation?.value ?? 0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colors.primaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: ImageContent(
                      isOpened: isOpened,
                      image: widget.image,
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

  void bindingsInitAnimation(Duration timeStamp) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double minPadding = maxHeight * 0.3;
    final double maxPadding = maxHeight * 0.75;

    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _paddingAnimation = Tween<double>(begin: maxPadding, end: minPadding).animate(curvedAnimation);
    _containerSizeAnimation = Tween<double>(begin: minPadding, end: maxPadding).animate(curvedAnimation);
    _imageSizeAnimation = Tween<double>(begin: maxPadding + 50.0, end: minPadding + 50.0).animate(curvedAnimation);
    setState(() {});
  }

  void changePosition() {
    isOpened = !isOpened;

    if (isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    _scaleStateController.reset();
    setState(() {});
  }
}
