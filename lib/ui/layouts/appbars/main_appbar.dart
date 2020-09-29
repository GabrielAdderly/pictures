import 'package:flutter/material.dart';

import 'package:pictures_view/theme/custom_theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final double height;
  final String title;

  final FocusNode focusNode;
  final TextEditingController controller;

  MainAppBar({
    @required this.title,
    @required this.focusNode,
    @required this.controller,
    this.height = 160.0,
  })  : preferredSize = Size.fromHeight(height),
        assert(title != null, throw ('You forgot filled title!')),
        super(key: const Key('MainAppBar'));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomTheme.colors.accentColor,
      child: SafeArea(
        top: true,
        child: Container(
          height: height,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 4.0,
          ),
          child: Column(
            children: <Widget>[
              Spacer(),
              Text(
                title,
                style: CustomTheme.textStyles.titleTextStyle(
                  size: 20.0,
                  height: 1.3,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                height: 48.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF16191D),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 5.0,
                ),
                child: TextFormField(
                  textDirection:      TextDirection.ltr,
                  focusNode:          focusNode,
                  controller:         controller,
                  onFieldSubmitted:   (String value) {},
                  onChanged:          (String value) {},
                  autovalidate:       true,
                  keyboardType:       TextInputType.text,
                  textAlignVertical:  TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                  maxLines: 1,
                  cursorColor: Color(0xFFF06500),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color(0xFF979797),
                    ),
                    alignLabelWithHint: true,
                    hintText: 'Search',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
