import 'package:flutter/foundation.dart';

import 'package:redux/redux.dart';

import 'package:pictures_view/res/typedef.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/shared/route_selectors.dart';
import 'package:pictures_view/store/images_state/images_selector.dart';

class AnimatedGridViewModel {
  final NavigateToFunction navigateTo;
  final void Function(CardDTO) selectImage;

  AnimatedGridViewModel({
    @required this.selectImage,
    @required this.navigateTo,
  });

  static AnimatedGridViewModel fromStore(Store<AppState> store) {
    return AnimatedGridViewModel(
      navigateTo: RouteSelectors.navigateTo(store),
      selectImage: ImagesSelector.getSelectImageFunction(store),
    );
  }
}