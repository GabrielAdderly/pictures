import 'package:flutter/material.dart';

import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/models/dtos/category_dto.dart';

import 'package:pictures_view/ui/animations/jump_to_state_mixin.dart';

class CategoriesList extends AdditionalStatefulWidget {
  final Function selectCallback;
  final List<CategoryDTO> categories;

  CategoriesList({
    @required Key key,
    @required this.categories,
    this.selectCallback,
    double height = 36.0,
  }) : super(key: key, height: height);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends AdditionalState<CategoriesList> with JumpToStateMixin {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, AVTheme theme, Language dictionary) {
    return Container(
      height: widget.getHeight,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final GlobalKey categoryWidgetKey = GlobalKey();
          return InkWell(
            onTap: () => _onTextTap(categoryWidgetKey, index),
            child: Container(
              key: categoryWidgetKey,
              margin: EdgeInsets.only(right: 55.0),
              height: 22.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.categories[index].text,
                    style: theme.textStyles.boldTextStyle(size: 16.0, height: 1.1),
                  ),
                  Container(
                    height: 2.0,
                    width: 15.0,
                    color: index == _selectedCategoryIndex ? theme.colors.accentColor : AppColors.kTransparent,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTextTap(GlobalKey key, int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    jumpTo(key.currentContext.findRenderObject());
    widget.selectCallback(index);
  }
}
