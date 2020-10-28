import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

import 'package:pictures_view/pikcha_main_lib.dart';
import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/ui/animations/animated_image_info_mixin.dart';
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

class ImageInfoBodyState extends ThemeState<ImageInfoBody> with SingleTickerProviderStateMixin, AnimatedImageInfoMixin {
  PhotoViewScaleStateController _scaleStateController;

  @override
  void initState() {
    super.initState();
    _scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    _scaleStateController.dispose();
    super.dispose();
  }

  @override
  void changePosition() {
    super.changePosition();
    _scaleStateController.reset();
    setState(() {});
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: getAnimatedImageSize,
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
          padding: EdgeInsets.only(top: getAnimatedPadding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: getAnimatedContainerSize,
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
}
