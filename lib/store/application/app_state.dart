import 'package:flutter/foundation.dart';
import 'package:pictures_view/store/images_state/images_state.dart';

import 'package:pictures_view/store/shared/layouts/layout_epics.dart';
import 'package:pictures_view/store/shared/layouts/layout_state.dart';

import 'package:redux_epics/redux_epics.dart';

import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/store/shared/dialog_state/dialog_state.dart';
import 'package:pictures_view/store/shared/initialization/initialize_epic.dart';


import 'package:pictures_view/store/pages/settings_page_state/settings_page_state.dart';

class AppState {
  DialogState dialogState;
  LayoutState layoutState;
  ImagesState imagesState;
  SettingsPageState settingsPageState;

  AppState({
    @required this.dialogState,
    @required this.layoutState,
    @required this.imagesState,
    @required this.settingsPageState,
  });

  factory AppState.initial() {
    return AppState(
      dialogState: DialogState.initial(),
      layoutState: LayoutState.initial(),
      imagesState: ImagesState.initial(),
      settingsPageState: SettingsPageState.initial(),
    );
  }

  static AppState getReducer(AppState state, dynamic action) {
    const String TAG = '[appReducer]';

    logger.i('$TAG  => <appReducer> => action: ${action.runtimeType}');

    return AppState(
      layoutState: state.layoutState.reducer(action),
      dialogState: state.dialogState.reducer(action),
      imagesState: state.imagesState.reducer(action),
      settingsPageState: state.settingsPageState.reducer(action),
    );
  }

  static final getAppEpic = combineEpics<AppState>([
    LayoutEpics.indexEpic,
    InitializeEpics.indexEpic,
  ]);
}
