import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

enum RequestType {
  get,
  post,
}

class BaseClient {
  static final Dio _dio = Dio();
  static get dio => _dio;
  static safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function()? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      await onLoading?.call();
      // 2) try to perform http request
      late Response response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioException {
      // dio error (api reach the server but not performed successfully
    } on SocketException {
      // No internet connection
    } on TimeoutException {
      // Api call went out of time
    } catch (error) {
      // unexpected error for example (parsing json error)
    }
  }
}
