import 'package:pictures_view/models/interfaces/i_dto.dart';

class GetColorSchemeResponseDto implements IDto {
  final List<List<int>> result;
  GetColorSchemeResponseDto({this.result});

  factory GetColorSchemeResponseDto.fromMap(Map<String, dynamic> map) {
    return GetColorSchemeResponseDto(
      result: map['result'] as List<List<int>>,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
    };
  }
}