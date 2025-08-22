import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../di/injector.dart';
import '../data/session_manager.dart';
import 'api_error.dart';
import 'url_config.dart';

/// description: A network provider class which manages network connections
/// between the app and external services. This is a wrapper around [Dio].
///
/// Using this class automatically handle, token management, logging, global

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

/// A top level function to print dio logs
void printDioLogs(Object object) {
  if (kDebugMode) {
    printWrapped(object.toString());
  }
}

class NetworkService {
  static const CONNECT_TIME_OUT = Duration(seconds: 30);
  static const RECEIVE_TIME_OUT = Duration(seconds: 30);

  Dio? dio;
  String? baseUrl, authToken;

  NetworkService(
      {String? baseUrl, String? authToken, bool? enableLogger = false}) {
    this.baseUrl = baseUrl;
    this.authToken = authToken;
    _initialiseDio(enableLogger: enableLogger);
  }

  /// Initialize essential class properties
  void _initialiseDio({bool? enableLogger = false}) {
    dio = Dio(BaseOptions(
      connectTimeout: CONNECT_TIME_OUT,
      receiveTimeout: RECEIVE_TIME_OUT,
      baseUrl: baseUrl ?? UrlConfig.coreBaseUrl,
    ));
    authToken ??= SessionManager.instance.authToken;
    dio!.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: printDioLogs,

    ));

    if (enableLogger!) {
      dio?.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 400,
        ),
      );
    }

    // dio!.interceptors.add(AppInterceptor(authToken ?? ''));
  }

  /// Factory constructor used mainly for injecting an instance of [Dio] mock
  NetworkService.test(this.dio);

  Future<Response> call(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    data,
    FormData? formData,
    Map<String, dynamic>? extras,
    ResponseType responseType = ResponseType.json,
    classTag = '',
  }) async {
    Response response;
    var params = queryParams ?? {};
    if (params.keys.contains("searchTerm")) {
      params["searchTerm"] = Uri.encodeQueryComponent(params["searchTerm"]);
    }
    if (params.keys.contains("page")) {
      params["page"] = Uri.encodeQueryComponent(params["page"]);
    }
    try {
      logger.i(dio?.options.headers);
      logger.i(dio?.options.headers);
      switch (method) {

        case RequestMethod.post:
          response = await dio!.post(path,
              queryParameters: params,
              data: data,
              options: _getOptions(extras: extras));

          break;
        case RequestMethod.get:
          response = await dio!.get(path,
              queryParameters: params, options: _getOptions(extras: extras));
          break;
        case RequestMethod.put:
          response = await dio!.put(path,
              queryParameters: params,
              data: data,
              options: _getOptions(extras: extras));
          break;
        case RequestMethod.patch:
          response = await dio!.patch(path,
              queryParameters: params,
              data: data,
              options: _getOptions(extras: extras));
          break;
        case RequestMethod.delete:
          response = await dio!.delete(path,
              queryParameters: params,
              data: data,
              options: _getOptions(extras: extras));
          break;
        case RequestMethod.upload:
          response = await dio!.post(path,
              data: formData,
              queryParameters: params,
              options: Options(
                  headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Disposition": "form-data",
                "Content-Type": "multipart/form-data",
              }..addAll(extras ?? {})),
              onSendProgress: (sent, total) {});
          break;
        case RequestMethod.uploadPut:
          response = await dio!.put(path,
              data: formData,
              queryParameters: params,
              options: Options(
                  headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                // "Content-Disposition": "form-data",
                // "Content-Type": "multipart/form-data",
              }..addAll(extras ?? {})),
              onSendProgress: (sent, total) {});
          break;

        case RequestMethod.putSecond:
          response = await dio!.put(path,
              data: data,
              queryParameters: params,
              options: Options(
                  headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Type": "application/json",
              }..addAll(extras ?? {})),
              onSendProgress: (sent, total) {});
          break;
      }

      if (response.data is List) {
        return response;
      } else {
        if (response.data['errors'] != null) {
          logger.i(response.data.toString());
          var apiError = ApiError.fromResponse(response);

          return Future.error(apiError);

        } else {
          return response;
        }
      }
    } catch (error, stackTrace) {
      if (error is DioException) {
        if (error.response?.statusCode == 308) {
          logger.e(error.response?.headers);

          response = await dio!.post(
            error.response!.headers["location"]!.join().toString(),
            queryParameters: params,
            data: data,
            options: _getOptions(),
          );

          return response;
        }

        var apiError = ApiError.fromDio(error);

        return Future.error(apiError, stackTrace);
      }

      logger.e(error.toString());

      var apiError = ApiError.unknown(error);
      if (apiError.errorType == 401) {}

      return Future.error(apiError, stackTrace);
    }
  }

  _getOptions({Map<String, dynamic>? extras}) {
    return Options(
        contentType: Headers.jsonContentType,
        headers: {
          if(SessionManager.instance.authToken.isNotEmpty)
          HttpHeaders.authorizationHeader: "Bearer ${SessionManager.instance.authToken}",
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }..addAll(extras ?? {}));

  }

}

// onError:(error, handler)async {
//   if(error.response?.statusCode==401){
//     final newtoken=await refreshToken();
//     if(newtoken!=null){
//       _dio.
// }
//
// }

// }

enum RequestMethod {
  post,
  get,
  put,
  patch,
  delete,
  upload,
  uploadPut,
  putSecond,
}
