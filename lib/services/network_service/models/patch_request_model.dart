import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:pictures_view/services/network_service/interfaces/i_base_request.dart';

class PatchRequestModel implements IBaseRequest {
  final String url;
  final Map<String, String> headers;
  final Map<String, String> body;

  PatchRequestModel({
    this.url,
    this.headers,
    this.body,
  });

  @override
  Future<Response> call() {
    return http.patch(
      url,
      headers: headers,
      body: body,
    );
  }
}
