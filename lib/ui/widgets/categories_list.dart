import 'package:flutter/material.dart';

import 'package:pictures_view/pic_main_lib.dart';

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
  List<GlobalKey> _globalKeys;

  @override
  void initState() {
    super.initState();
    createKeys();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, CustomTheme theme, Dictionary dictionary) {
    return Container(
      height: widget.getHeight,
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => _onTextTap(index),
            child: Container(
              key: _globalKeys[index],
              margin: EdgeInsets.only(right: 55.0),
              height: 26.0,
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
                    color: index == _selectedCategoryIndex ? theme.colors.iconColor : AppColors.kTransparent,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void createKeys() {
    _globalKeys = [];

    for (int i = 0; i < widget.categories.length; i++) {
      _globalKeys.add(GlobalKey(debugLabel: widget.categories[i].text));
    }
  }

  void _onTextTap(int index) {
    _selectedCategoryIndex = index;
    setState(() {});
    jumpTo(_globalKeys[index].currentContext.findRenderObject());
    widget.selectCallback(index);
  }
}
