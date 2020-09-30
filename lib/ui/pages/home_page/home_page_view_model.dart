import 'package:redux/redux.dart';

import 'package:pictures_view/store/application/app_state.dart';

class HomePageViewModel {
  HomePageViewModel();

  static HomePageViewModel fromStore(Store<AppState> store) {
    return HomePageViewModel();
  }
}