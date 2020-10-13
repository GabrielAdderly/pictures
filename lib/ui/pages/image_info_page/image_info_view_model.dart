import 'package:redux/redux.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

import 'package:pictures_view/store/application/app_state.dart';
import 'package:pictures_view/store/images_state/images_selector.dart';

class ImageInfoViewModel {
  final CardDTO image;

  ImageInfoViewModel({this.image,});

  static ImageInfoViewModel fromStore(Store<AppState> store) {
    return ImageInfoViewModel(
      image: ImagesSelector.getImage(store),
    );
  }

}