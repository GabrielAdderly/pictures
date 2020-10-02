import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

class SearchAppBar extends ThemeStatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final double height;

  final String title;
  final AdditionalAppbarWidget additionalAppBarElement;

  final FocusNode focusNode;
  final TextEditingController controller;

  SearchAppBar({
    @required this.title,
    this.controller,
    this.focusNode,
    this.height = 160.0,
    this.additionalAppBarElement = const NonAdditionalStatelessWidget(),
  })  : preferredSize = Size.fromHeight(height + additionalAppBarElement.getHeight),
        assert(title != null, throw ('You forgot filled title!')),
        super(key: const Key('MainAppBar'));

  @override
  Widget buildWidget(BuildContext context, AVTheme theme) {
    return Container(
      color: theme.colors.accentColor,
      child: SafeArea(
        top: true,
        child: Container(
          height: height + additionalAppBarElement.getHeight,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 4.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(),
              Text(
                title,
                style: theme.textStyles.titleTextStyle(height: 1.3),
              ),
              SizedBox(height: 24.0),
              Container(
                height: 48.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF16191D),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 5.0,
                ),
                child: TextFormField(
                  textDirection: TextDirection.ltr,
                  focusNode: focusNode,
                  controller: controller,
                  onFieldSubmitted: (String value) {},
                  onChanged: (String value) {},
                  autovalidate: true,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                  maxLines: 1,
                  cursorColor: Color(0xFFF06500),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF979797)),
                    alignLabelWithHint: true,
                    hintText: 'Search',
                  ),
                ),
              ),
              if (additionalAppBarElement.isNotEmpty) SizedBox(height: 8.0),
              additionalAppBarElement,
            ],
          ),
        ),
      ),
    );
  }
}
