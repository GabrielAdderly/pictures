import 'dart:convert';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pictures_view/services/network_service/interfaces/i_base_request.dart';
import 'package:pictures_view/services/network_service/models/base_error.dart';
import 'package:pictures_view/services/network_service/res/typedef.dart';

import 'models/base_http_error.dart';
import 'models/base_http_response.dart';
import 'res/consts.dart';

class NetworkService {
  static const tag = '[NetworkService]';

  NetworkService._privateConstructor();

  static final NetworkService _instance = NetworkService._privateConstructor();

  static NetworkService get instance => _instance;

  String baseUrl;
  List<BaseError> _errors = [];

  void overrideBaseUrl(String url) => baseUrl = baseUrl;

  void init({
    @required String baseUrl,
    @required List<BaseError> errors,
  }) {
    baseUrl = baseUrl;
    _errors = errors;
  }

  Future<BaseHttpResponse> request(IBaseRequest request) async {
    final BaseHttpResponse checkConnection = await _checkInternetConnection();
    if (checkConnection != null) return checkConnection;

    final http.Response response = await request();

    print('response: ${response.body}');

    return _getCheckedForErrorResponse(response);
  }

  BaseHttpResponse _getCheckedForErrorResponse(http.Response response) {
    if (response.statusCode < HTTP_OK || response.statusCode > HTTP_MAX_OK) {
      return BaseHttpResponse(
        error: BaseHttpError(
          error: response?.reasonPhrase,
          statusCode: response?.statusCode,
        ),
      );
    }

    if (response.statusCode == HTTP_UNPROCESSABLE) {
      try {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        int code = responseBody[DATA];
        String error = _getErrorByCode(code);

        if (error == null) {
          return BaseHttpResponse(
            error: BaseHttpError(
              error: response?.reasonPhrase,
              statusCode: response?.statusCode,
            ),
          );
        }

        return BaseHttpResponse(
          error: BaseHttpError(
            error: error,
            statusCode: code,
          ),
        );
      } catch (e) {
        return BaseHttpResponse(
          error: BaseHttpError(
            error: response?.reasonPhrase,
            statusCode: response?.statusCode,
          ),
        );
      }
    }

    return BaseHttpResponse(
      response: jsonDecode(response.body),
    );
  }

  Future<BaseHttpResponse> _checkInternetConnection() async {
    final bool hasInternet = await DataConnectionChecker().hasConnection;

    if (!hasInternet) {
      return BaseHttpResponse(
        error: BaseHttpError(
          error: NO_INTERNET_CONNECTION,
          statusCode: BAD_GATEWAY_STATUS_CODE,
        ),
      );
    }

    return null;
  }

  String _getErrorByCode(int code) {
    for (BaseError error in _errors) {
      if (error.statusCode == code) {
        return error.error;
      }
    }

    return null;
  }
}
