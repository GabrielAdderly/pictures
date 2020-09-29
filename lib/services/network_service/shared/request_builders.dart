import 'package:flutter/material.dart';
import 'package:pictures_view/services/network_service/interfaces/i_base_request.dart';
import 'package:pictures_view/services/network_service/models/delete_request_model.dart';
import 'package:pictures_view/services/network_service/models/get_request_model.dart';
import 'package:pictures_view/services/network_service/models/patch_request_model.dart';
import 'package:pictures_view/services/network_service/models/post_request_model.dart';
import 'package:pictures_view/services/network_service/models/put_request_model.dart';
import 'package:pictures_view/services/network_service/network_service.dart';
import 'package:pictures_view/services/network_service/res/consts.dart';

class RequestBuilders {
  static IBaseRequest get({
    @required String functionName,
    String url,
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
    Map<String, String> params,
  }) {
    url = _attachParams(
      url: url ?? NetworkService.instance.baseUrl,
      params: params,
      functionName: functionName,
    );

    headers = _attachHeaders(
      token: token,
      headers: headers,
      tokenEntry: tokenEntry,
    );

    return GetRequestModel(
      url: url,
      headers: headers,
    );
  }

  static IBaseRequest post({
    @required String functionName,
    String url,
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
    Map<String, String> params,
    Map<String, String> body = const {},
  }) {
    url = _attachParams(
      url: url ?? NetworkService.instance.baseUrl,
      params: params,
      functionName: functionName,
    );

    headers = _attachHeaders(
      token: token,
      headers: headers,
      tokenEntry: tokenEntry,
    );

    return PostRequestModel(
      url: url,
      headers: headers,
      body: body,
    );
  }

  static IBaseRequest put({
    @required String functionName,
    String url,
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
    Map<String, String> params,
    Map<String, String> body = const {},
  }) {
    url = _attachParams(
      url: url ?? NetworkService.instance.baseUrl,
      params: params,
      functionName: functionName,
    );

    headers = _attachHeaders(
      token: token,
      headers: headers,
      tokenEntry: tokenEntry,
    );

    return PutRequestModel(
      url: url,
      headers: headers,
      body: body,
    );
  }

  static IBaseRequest delete({
    @required String functionName,
    String url,
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
    Map<String, String> params,
  }) {
    url = _attachParams(
      url: url ?? NetworkService.instance.baseUrl,
      params: params,
      functionName: functionName,
    );

    headers = _attachHeaders(
      token: token,
      headers: headers,
      tokenEntry: tokenEntry,
    );

    return DeleteRequestModel(
      url: url,
      headers: headers,
    );
  }

  static IBaseRequest patch({
    @required String functionName,
    String url,
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
    Map<String, String> params,
    Map<String, String> body = const {},
  }) {
    url = _attachParams(
      url: url ?? NetworkService.instance.baseUrl,
      params: params,
      functionName: functionName,
    );

    headers = _attachHeaders(
      token: token,
      headers: headers,
      tokenEntry: tokenEntry,
    );

    return PatchRequestModel(
      url: url,
      headers: headers,
      body: body,
    );
  }

  static String _attachParams({
    String url,
    String functionName,
    Map<String, String> params,
  }) {
    String originalRoute = functionName;

    if (params != null) {
      final List<String> paramStrings = params
          .map((key, value) => MapEntry(
                key,
                _createParamString(key, value),
              ))
          .values
          .toList();

      for (int i = 0; i < paramStrings.length; i++) {
        originalRoute += i == 0 ? '?' : '&';
        originalRoute += paramStrings[i];
      }
    }

    return url + originalRoute;
  }

  static Map<String, String> _attachHeaders({
    String token,
    MapEntry tokenEntry,
    Map<String, String> headers,
  }) {
    headers ??= {};

    headers = _addDefaultHeaders(headers: headers);

    if (token != null) {
      headers = _addBearerToken(
        token: token,
        headers: headers,
      );
    }

    if (tokenEntry != null) {
      headers = _addTokenEntryToHeaders(
        tokenEntry: tokenEntry,
        headers: headers,
      );
    }

    return headers;
  }

  static String _createParamString(String key, String value) {
    return key + '=' + value;
  }

  static Map<String, String> _addBearerToken({
    String token,
    Map<String, String> headers,
  }) {
    headers ??= {};

    if (token != null) {
      headers.addEntries([MapEntry(TOKEN_KEY, BEARER_BASE + token)]);
    }

    return headers;
  }

  static Map<String, String> _addTokenEntryToHeaders({
    MapEntry<String, String> tokenEntry,
    Map<String, String> headers,
  }) {
    headers ??= {};

    if (tokenEntry != null) {
      headers.addEntries([tokenEntry]);
    }

    return headers;
  }

  static Map<String, String> _addDefaultHeaders({
    Map<String, String> headers,
  }) {
    headers ??= {};

    headers.addEntries([
      MapEntry(ACCEPT, CONTENT_TYPE_VALUE),
      MapEntry(CONTENT_TYPE_KEY, CONTENT_TYPE_VALUE),
    ]);

    return headers;
  }
}
