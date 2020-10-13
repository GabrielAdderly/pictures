import 'package:http/http.dart' as http;
import 'package:pictures_view/services/network_service/interfaces/i_base_request.dart';

class DeleteRequestModel implements IBaseRequest {
  final String url;
  final Map<String, String> headers;

  DeleteRequestModel({
    this.url,
    this.headers,
  });

  @override
  Future<http.Response> call() {
    return http.delete(
      url,
      headers: headers,
    );
  }
}
