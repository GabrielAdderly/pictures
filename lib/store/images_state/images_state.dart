import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'actions/images_actions.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';
import 'package:pictures_view/store/shared/reducer.dart';

class ImagesState {
  final List<CardDTO> imagesUrl;
  final CardDTO selectedImageUrl;

  ImagesState({
    @required this.imagesUrl,
    @required this.selectedImageUrl,
  });

  factory ImagesState.initial() {
    return ImagesState(
      imagesUrl: [],
      selectedImageUrl: CardDTO.empty(),
    );
  }

  ImagesState copyWith({
    List<CardDTO> imagesUrl,
    CardDTO selectedImageUrl,
  }) {
    return ImagesState(
      imagesUrl: imagesUrl ?? this.imagesUrl ?? CardDTO.empty(),
      selectedImageUrl: selectedImageUrl ?? this.selectedImageUrl,
    );
  }

  ImagesState reducer(dynamic action) {
    return Reducer<ImagesState>(
      actions: HashMap.from({
        SelectImageAction: (dynamic action) => _selectImage(action as SelectImageAction),
      }),
    ).updateState(action, this);
  }

  ImagesState _selectImage(SelectImageAction action) => copyWith(selectedImageUrl: action.image);
}
