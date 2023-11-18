import 'package:dio/dio.dart';

import '../../../../core/utils/app_logger.dart';

class LoggerInterceptor extends Interceptor {
  final Dio dio;

  LoggerInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logMessage('REQUEST[${options.method}] => PATH: ${options.uri}');
    logMessage('REQUEST QUERY PARAMS: ${options.queryParameters}');
    logMessage('REQUEST HEADERS:${options.headers}');
    logMessage('REQUEST DATA:${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    logMessage(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    logMessage('RESPONSE DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logMessage(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}, METHOD: ${err.requestOptions.method}');
    logMessage("ERROR: ${err.error}");
    logMessage("DATA\n${err.response?.data}");
    super.onError(err, handler);
  }
}
