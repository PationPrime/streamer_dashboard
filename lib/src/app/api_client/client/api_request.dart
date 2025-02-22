import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class RTAPIRequest extends Equatable {
  final RequestOptions options;
  final RequestInterceptorHandler handler;

  const RTAPIRequest(this.options, this.handler);

  RTAPIRequest copyWith({
    RequestOptions? options,
    RequestInterceptorHandler? handler,
  }) =>
      RTAPIRequest(
        options ?? this.options,
        handler ?? this.handler,
      );

  @override
  List<Object?> get props => [
        options,
        handler,
      ];
}
