import 'package:flutter/material.dart';
import 'package:pictures_view/pikcha_main_lib.dart';

import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/widgets/clean_behavior.dart';

import 'package:pictures_view/ui/animations/jump_to_state_mixin.dart';

class SettingsHeader extends AdditionalStatefulWidget {
  final List<String> titles;
  final void Function(int) callback;

  const SettingsHeader({
    @required this.titles,
    @required this.callback,
    double height = 70.0,
    Key key,
  }) : super(key: key, height: height);

  @override
  _SettingsHeaderState createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends AdditionalState<SettingsHeader> with JumpToStateMixin {
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
    jumpTo(key.currentContext.findRenderObject());
    widget.callback(index);
  }
}


