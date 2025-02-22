import 'package:dio/dio.dart';

import '../../config/environment/environment.dart';

base class ApiClient {
  final AppEnvironment environment;
  final Map<String, dynamic> headers;
  final List<Interceptor> interceptors;
  final String? baseUrl;

  const ApiClient({
    required this.environment,
    this.headers = const {},
    this.interceptors = const [],
    this.baseUrl,
  });

  @override
  String toString() =>
      "environment: $environment\nheaders: $headers\ninterceptors: $interceptors\nbaseUrl: $baseUrl";

  Dio get apiClient => Dio(
        BaseOptions(
          baseUrl: baseUrl ?? environment.baseUrl,
          headers: {
            ...headers,
          },
          contentType: Headers.jsonContentType,
          connectTimeout: Duration(
            milliseconds: environment.connectTimeout,
          ),
          receiveTimeout: Duration(
            milliseconds: environment.receiveTimeout,
          ),
        ),
      )..interceptors.addAll(
          interceptors,
        );
}
