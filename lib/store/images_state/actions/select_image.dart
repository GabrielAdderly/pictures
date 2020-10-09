import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/store/shared/base_action.dart';

class SelectImageAction extends BaseAction {
  final CardDTO image;

  SelectImageAction({this.image}) : super (type: 'SelectImageAction');
}