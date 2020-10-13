import 'package:redux/redux.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/images_state/actions/images_actions.dart';

class ImagesSelector {
  static CardDTO getImage(Store<AppState> store) {
    return store.state.imagesState.selectedImageUrl;
  }

  static void Function(CardDTO) getSelectImageFunction(Store<AppState> store) {
    return (CardDTO image) => store.dispatch(SelectImageAction(image: image));
  }
}
