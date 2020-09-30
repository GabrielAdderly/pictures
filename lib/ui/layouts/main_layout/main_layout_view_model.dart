import 'package:pictures_view/theme/models/appvesto_theme.dart';
import 'package:redux/redux.dart';

import 'package:pictures_view/store/application/app_state.dart';

class MainLayoutViewModel {
  AVTheme avTheme;

  MainLayoutViewModel();

  static MainLayoutViewModel fromStore(Store<AppState> store) {
    return MainLayoutViewModel();
  }
}
