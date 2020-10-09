import 'package:flutter/material.dart';
import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';

import 'package:pictures_view/ui/animations/jump_to_state_mixin.dart';

class SettingsHeader extends AdditionalStatefulWidget {
  final List<String> titles;
  final void Function(int) callback;

  const SettingsHeader({
    @required this.titles,
    @required this.callback,
    double height = 71.0,
    Key key,
  }) : super(key: key, height: height);

  @override
  _SettingsHeaderState createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends AdditionalState<SettingsHeader> with JumpToStateMixin {
  int _selectedCategoryIndex = 0;
  List<GlobalKey> _globalKeys;

  @override
  void initState() {
    super.initState();
    initController();
    createKeys();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, AVTheme theme, Dictionary dictionary) {
    return SizedBox(
      height: widget.getHeight,
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: CleanBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.titles.length,
          itemBuilder: (BuildContext context, int index) {
            final GlobalKey imageGK = GlobalKey();
            return InkWell(
              key: _globalKeys[index],
              onTap: () => _onTextTap(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.titles[index],
                      style: theme.textStyles.primaryTextStyle(
                        size: 24.0,
                        height: 1.2,
                      ),
                    ),
                    if (widget.titles.length > 1)
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
      ),
    );
  }

  void createKeys() {
    _globalKeys = [];

    for (int i = 0; i < widget.titles.length; i++) {
      _globalKeys.add(GlobalKey(debugLabel: widget.titles[i]));
    }
  }

  void _onTextTap(int index) {
    _selectedCategoryIndex = index;
    setState(() {});
    jumpTo(_globalKeys[index].currentContext.findRenderObject());
    widget.callback(index);
  }
}
