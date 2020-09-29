import 'package:http/http.dart';
import 'package:pictures_view/services/network_service/models/base_http_response.dart';

abstract class IBaseRequest {
  Future<Response> call();
}