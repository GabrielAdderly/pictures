import 'package:flutter/material.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/widgets/clean_behavior.dart';

class SettingsHeader extends StatefulWidget {
  final List<String> titles;
  final void Function(int) callback;

  const SettingsHeader({
    @required this.titles,
    @required this.callback,
    Key key,
  }) : super(key: key);

  @override
  _SettingsHeaderState createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends State<SettingsHeader> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: CleanBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.titles.length,
          itemBuilder: (BuildContext context, int index) {
            final GlobalKey imageGK = GlobalKey();
            return InkWell(
              key: imageGK,
              onTap: () => _onTextTap(imageGK, index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Text(
                  widget.titles[index],
                  style: CustomTheme.textStyles.primaryTextStyle(
                    size: 24.0,
                    height: 1.2,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTextTap(GlobalKey key, int index) {
    final RenderBox box = key.currentContext.findRenderObject();
    final Offset position = box.localToGlobal(Offset.zero);
    final double x = position.dx;
    _controller.animateTo(
      x + _controller.offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
    );
    widget.callback(index);
  }
}


