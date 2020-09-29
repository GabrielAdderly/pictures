import 'package:redux/redux.dart';

import 'package:pictures_view/store/application/app_state.dart';

import 'package:pictures_view/store/shared/initialization/actions/start_initialization.dart';

class InitializeSelectors {
  static void startInitialization(Store<AppState> store) {
    return store.dispatch(StartInitialization())();
  }
}
