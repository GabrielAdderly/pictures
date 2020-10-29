import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rive/rive.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/res/image_assets.dart';
import 'package:pictures_view/res/app_styles/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  final double size;
  final bool isLiked;
  final Color activeColor;
  final Color inactiveColor;
  final EdgeInsets padding;
  final BooleanCallback likeCallback;

  const FavoriteButton({
    @required this.isLiked,
    @required this.likeCallback,
    this.size = 12.0,
    this.activeColor = AppColors.kLikeColor,
    this.inactiveColor = AppColors.kGrey,
    this.padding = const EdgeInsets.all(3.0),
    Key key,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin {
  bool isLiked;
  Artboard _riveArtBoard;
  RiveAnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    _initRive;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _togglePlay,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: _getRiveArtBoard,
      ),
    );
  }

  Widget get _getRiveArtBoard {
    if (_riveArtBoard == null) return const SizedBox();
    return Rive(artboard: _riveArtBoard);
  }

  void _togglePlay() {
    isLiked = !isLiked;
    if (widget.likeCallback != null) widget.likeCallback(isLiked);

    _riveArtBoard.removeController(_controller);

    _chooseController;

    _controller.isActive = true;
    setState(() {});
  }

  void _addController(String animationName) {
    _riveArtBoard.addController(
      _controller = SimpleAnimation(animationName),
    );
  }

  void get _chooseController {
    if (isLiked) {
      _addController('forward');
    } else {
      _addController('backward');
    }
  }

  void get _initRive {
    rootBundle.load(ImageAssets.favoriteButtonRive).then(
      (ByteData data) async {
        final RiveFile file = RiveFile();

        if (file.import(data)) {
          _riveArtBoard = file.mainArtboard;
          _chooseController;

          _controller.isActive = false;
          setState(() {});
        }
      },
    );
  }
}
