import 'package:flutter/material.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';
import 'package:pictures_view/ui/extensions/widget_extensions.dart';

class CategoriesList extends StatefulWidget {
  final Function selectCallback;
  final List<CategoryDTO> categories;

  CategoriesList({
    @required Key key,
    @required this.categories,
    this.selectCallback,
  }) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final ScrollController _controller = ScrollController();
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final GlobalKey categoryWidgetKey = GlobalKey();
          return Container(
            key: categoryWidgetKey,
            margin: EdgeInsets.only(
              right: 55.0,
            ),
            height: 22.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.categories[index].text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 2,
                  width: 15,
                  color: index == _selectedCategoryIndex
                      ? Color(0xFFF06500)
                      : Color(0x00000000),
                ),
              ],
            ).onTap(() => _onTextTap(categoryWidgetKey, index)),
          );
        },
      ),
    );
  }

  void _onTextTap(GlobalKey key, int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });

    final RenderBox box = key.currentContext.findRenderObject();
    final Offset position = box.localToGlobal(Offset.zero);
    final double x = position.dx;
    _controller.animateTo(
      x + _controller.offset - 16.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
    );
    widget.selectCallback(index);
  }
}
