import 'package:flutter/material.dart';
import 'package:pictures_view/services/focus_service.dart';

class NextButtonTextField extends StatelessWidget {
  final String focusKeyValue;
  final FocusService focusService;
  final TextEditingController controller;

  NextButtonTextField({
    this.focusKeyValue,
    this.focusService,
    this.controller,
  }) : super(key: Key(focusKeyValue));

  bool get _isControllerHaveData {
    return controller.text != null && controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusService.getKeyByValue(focusKeyValue)?.focusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        focusService.changeKeyOpeningStatus(
          status: !_isControllerHaveData,
          currentFocusKeyValue: focusKeyValue,
        );

        focusService.nextFocus(
          context: context,
          currentFocusKeyValue: focusKeyValue,
        );
      },
    );
  }
}
