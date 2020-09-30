import 'package:pictures_view/store/shared/base_action.dart';
import 'package:pictures_view/theme/models/appvesto_theme.dart';

class ChangeTheme extends BaseAction {
  final AVTheme theme;
  
  ChangeTheme(this.theme) : super (type: 'ChangeTheme');
}