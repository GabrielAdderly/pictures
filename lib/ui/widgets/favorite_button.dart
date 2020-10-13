import 'package:flutter/material.dart';
import 'package:pictures_view/res/app_styles/app_colors.dart';
import 'package:pictures_view/res/icons/bottom_bar_icons.dart';
import 'package:pictures_view/res/typedef.dart';

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

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Padding(
        padding: widget.padding,
        child: Icon(
          BottomBarIcons.favorites,
          size: widget.size,
          color: isLiked ? widget.activeColor : widget.inactiveColor,
        ),
      ),
    );
  }

  void _onTap() {
    isLiked = !isLiked;

    if (widget.likeCallback != null) widget.likeCallback(isLiked);

    setState(() {});
  }
}
