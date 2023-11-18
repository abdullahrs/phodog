import 'package:dio/dio.dart';

import 'interceptors/logger_interceptor.dart';

mixin RepositoryBaseSettings {
  static Duration connectTimeout = const Duration(seconds: 15);
  static Duration receiveTimeout = const Duration(seconds: 15);
  static Duration sendTimeout = const Duration(seconds: 15);

  BaseOptions baseOptions = BaseOptions(
    // can be obtained from environment
    baseUrl: 'https://dog.ceo/',
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    sendTimeout: sendTimeout,
    followRedirects: true,
    receiveDataWhenStatusError: true,
  );

  late List<Interceptor> interceptors = [
    LoggerInterceptor(
      Dio(baseOptions),
    ),
  ];
}
