import 'package:flutter/foundation.dart';

import 'package:pictures_view/store/shared/base_action.dart';

import 'package:pictures_view/dictionary/models/language.dart';

class ChangeDictionaryAction extends BaseAction {
  final Dictionary dictionary;

  ChangeDictionaryAction({@required this.dictionary}) : super(type: 'ChangeDictionaryAction');
}
