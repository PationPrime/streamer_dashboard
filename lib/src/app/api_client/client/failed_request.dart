import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class RTFailedAPIRequest extends Equatable {
  final DioException error;
  final ErrorInterceptorHandler handler;

  const RTFailedAPIRequest(
    this.error,
    this.handler,
  );

  RTFailedAPIRequest copyWith({
    DioException? error,
    ErrorInterceptorHandler? handler,
  }) =>
      RTFailedAPIRequest(
        error ?? this.error,
        handler ?? this.handler,
      );

  @override
  List<Object?> get props => [
        error,
        handler,
      ];
}
