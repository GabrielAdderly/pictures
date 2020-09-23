import 'dart:collection';

import 'package:pictures_view/services/dialog_service.dart';
import 'package:pictures_view/store/shared/dialog_state/actions/force_close_dialog_action.dart';
import 'package:pictures_view/store/shared/dialog_state/actions/show_dialog_action.dart';
import 'package:pictures_view/store/shared/reducer.dart';

class DialogState {
  DialogState();

  bool get isDialogDisplayed => DialogService.instance.isDisplayed;

  factory DialogState.initial() {
    return DialogState();
  }

  DialogState copyWith() {
    return DialogState();
  }

  DialogState reducer(dynamic action) {
    return Reducer<DialogState>(
      actions: HashMap.from({
        ShowDialogAction: (dynamic action) => _showDialogAction(action as ShowDialogAction),
        ForceCloseDialogAction: (dynamic action) => _forceCloseDialogAction(action as ForceCloseDialogAction),
      }),
    ).updateState(action, this);
  }

  DialogState _forceCloseDialogAction(ForceCloseDialogAction action) {
    DialogService.instance.close();
    return this;
  }

  DialogState _showDialogAction(ShowDialogAction action) {
    DialogService.instance.show(action.dialog);
    return this;
  }
}
