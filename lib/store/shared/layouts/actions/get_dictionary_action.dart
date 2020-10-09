import 'package:flutter/foundation.dart';

import 'package:pictures_view/store/shared/base_action.dart';

import 'package:pictures_view/dictionary/models/language.dart';

class GetDictionaryAction extends BaseAction {
  final Dictionary dictionary;

  GetDictionaryAction({@required this.dictionary}) : super(type: 'GetDictionaryAction');
}
