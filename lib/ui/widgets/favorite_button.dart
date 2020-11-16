import 'package:flutter/material.dart';

import 'package:pictures_view/res/typedef.dart';
import 'package:pictures_view/res/app_styles/app_colors.dart';
import 'package:pictures_view/res/icons/bottom_bar_icons.dart';

import 'package:pictures_view/ui/animations/rive_animated_heart_mixin.dart';

class FavoriteButton extends StatefulWidget {
  final double size;
  final bool isLiked;
  final Color activeColor;
  final Color inactiveColor;
  final BooleanCallback likeCallback;

  const FavoriteButton({
    @required this.isLiked,
    @required this.likeCallback,
    this.size = 12.0,
    this.inactiveColor = AppColors.kGrey,
    this.activeColor = AppColors.kLikeColor,
    Key key,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin, RiveAnimatedHeartMixin {
  bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  void togglePlay() {
    isLiked = !isLiked;
    if (widget.likeCallback != null) widget.likeCallback(isLiked);
    super.togglePlay();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: togglePlay,
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: getRiveIcon,
      ),
    );
  }

  @override
  Widget get placeHolderIcon {
    return Icon(
      BottomBarIcons.favorites,
      size: widget.size,
      color: isLiked ? AppColors.kLikeColor : AppColors.kGreyTwo,
    );
  }
}
