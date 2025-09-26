import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
// import '../../data/hive.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {},
      contentType: 'application/json; charset=utf-8',
    );

    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint(
            'REQUEST [${options.method}] => PATH: ${options.path} => QUERY_PARAMS: ${options.queryParameters} => DATA: ${options.data}',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('RESPONSE ${response.statusCode} ${response.realUri}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint('CODE: ${e.response?.statusCode}');
          debugPrint('CODE: ${e.response?.statusMessage}');
          // Do something with response error
          ErrorEntity eInfo = createErrorEntity(e);
          debugPrint('CODE: ${eInfo.code}');
          // override statusMessage
          e.response?.statusMessage = eInfo.message;

          return handler.next(e); //continue
          // If you want to complete the request and return some custom data, you can resolve a `Response`, such as `handler.resolve(response)`.
          // In this way, the request will be terminated, the upper then will be called, and the data returned in then will be your custom response.
        },
      ),
    );
  }

  /*
    + Error unified processing
    */
  // error message
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: 'Request cancellation');
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: 'Connection timed out');
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: 'Request timed out');
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: 'Response timeout');
      case DioExceptionType.badResponse:
        try {
          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return ErrorEntity(
                code: errCode,
                message: 'Request syntax error',
              );
            case 401:
              return ErrorEntity(code: errCode, message: 'Permission denied');
            case 403:
              return ErrorEntity(
                code: errCode,
                message: 'Server refused to execute',
              );
            case 404:
              return ErrorEntity(
                code: errCode,
                message: 'Can not reach server',
              );
            case 422:
              return ErrorEntity(
                code: errCode,
                message: 'Unprocessable content',
              );
            case 405:
              return ErrorEntity(
                code: errCode,
                message: 'Request method is forbidden',
              );
            case 500:
              return ErrorEntity(
                code: errCode,
                message: 'Server internal error',
              );
            case 502:
              return ErrorEntity(code: errCode, message: 'Invalid request');
            case 503:
              return ErrorEntity(code: errCode, message: 'Server hung up');
            case 505:
              return ErrorEntity(
                code: errCode,
                message: 'Does not support HTTP protocol request',
              );
            default:
              return ErrorEntity(
                code: errCode,
                message: error.response?.statusMessage,
              );
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: 'Unknown error');
        }
      default:
        return ErrorEntity(code: -1, message: error.message);
    }
  }

  /*
    Cancel Request
    The same cancel token can be used for multiple requests. When a cancel token is cancelled,
    all requests using the cancel token will be cancelled. So the parameters are optional
  */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  Map<String, dynamic> getHeaders() {
    // final accessToken = Boxes.boxString.get(Boxes.accessToken) ?? '';
    // final refreshToken = Boxes.boxString.get(Boxes.refreshToken) ?? '';
    // final lang = Boxes.boxString.get(Boxes.locale) ?? 'ru';

    // debugPrint('====================> Header TOKEN: $accessToken');
    // debugPrint('b $refreshToken');

    final Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      // 'Authorization': 'Bearer $accessToken',
      // 'X-LANG': lang,
    };
    // debugPrint('Headers: $headers');
    return headers;
  }

  /// restful get
  /// refresh false
  /// noCache true
  /// list  false
  /// cacheKey
  /// cacheDisk
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = false,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      'refresh': refresh,
      'noCache': noCache,
      'list': list,
      'cacheKey': cacheKey,
      'cacheDisk': cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getHeaders();
    requestOptions.headers!.addAll(authorization);

    // await Future.delayed(Duration(seconds: 10));

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getHeaders();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.post(
      path, // url
      data: data, // Map
      queryParameters: queryParameters, // https//api.pot.tm (?) -this
      options: requestOptions, // header
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future refreshToken(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // final refreshToken = Boxes.boxString.get(Boxes.refreshToken) ?? '';
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      // 'Authorization': 'Refresh $refreshToken',
    };
    requestOptions.headers!.addAll(authorization);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful put
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getHeaders();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getHeaders();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getHeaders();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    debugPrint('stop');
    return response.data;
  }

  /// restful post form
  /*Future postForm(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }*/

  /// restful post Stream
  /*Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  } */
}

// Exception handling
class ErrorEntity implements Exception {
  int? code;
  String? message;

  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: code $code, $message';
  }
}
