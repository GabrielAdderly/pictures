import 'package:pictures_view/res/const.dart';

import 'package:pictures_view/models/dtos/get_color_scheme_response_dto.dart';

import 'package:pictures_view/network/shared/i_request.dart';

import 'package:pictures_view/services/network_service/network_service.dart';
import 'package:pictures_view/services/network_service/shared/request_builders.dart';
import 'package:pictures_view/services/network_service/models/base_http_response.dart';

class GetDefaultColorScheme implements IRequest<GetColorSchemeResponseDto> {
  @override
  Future<GetColorSchemeResponseDto> call() async {
    final BaseHttpResponse response = await NetworkService.instance.request(
      RequestBuilders.get(
        url: 'http://colormind.io/api/',
        functionName: kEmptyString,
      ),
    );

    final Map<String, dynamic> map = response.response;

    return GetColorSchemeResponseDto.fromMap(map);
  }
}
