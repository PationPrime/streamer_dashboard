import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../failure/failure.dart';
import '../../router/navigator_key_provider.dart';
import '../../tools/tools.dart';
import '../constants/failure_constants.dart';

part 'error_handler.dart';
part 'waf_errors.dart';

class ApiError extends Equatable {
  final String code;
  final String message;
  final Map<String, dynamic> rawBody;
  final StackTrace? stackTrace;
  final DioException? dioException;

  const ApiError({
    required this.code,
    required this.message,
    this.rawBody = const <String, dynamic>{},
    this.stackTrace,
    this.dioException,
  });

  @override
  List<Object?> get props => [
        code,
        message,
        rawBody,
        stackTrace,
        dioException,
      ];

  ApiError copyWith({
    String? code,
    String? message,
    Map<String, dynamic>? rawBody,
    StackTrace? stackTrace,
    DioException? dioException,
  }) =>
      ApiError(
        code: code ?? this.code,
        message: message ?? this.message,
        rawBody: rawBody ?? this.rawBody,
        stackTrace: stackTrace ?? this.stackTrace,
        dioException: dioException ?? this.dioException,
      );
}
