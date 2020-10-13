import 'package:http/http.dart';

abstract class IBaseRequest {
  Future<Response> call();
}