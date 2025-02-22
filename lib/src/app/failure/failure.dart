import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String title;
  final String? code;
  final String message;
  final Map<String, dynamic>? response;
  final StackTrace? stackTrace;
  final DioException? dioException;

  const Failure({
    this.title = "Error",
    this.code,
    this.message = "Something went wrong",
    this.response,
    this.stackTrace,
    this.dioException,
  });

  @override
  List<Object?> get props => [
        title,
        code,
        message,
        stackTrace,
        response,
        dioException,
      ];
}

/// Глобальная неизвестная ошибка
class UnknownFailure extends Failure {
  @override
  List<Object?> get props => [];
}
