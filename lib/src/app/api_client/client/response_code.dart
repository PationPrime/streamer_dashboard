// ignore_for_file: constant_identifier_names

part of 'base_client.dart';

abstract class RTResponseCode {
  static const OK = 200;
  static const SPECIFIC_ERROR = 301;
  static const BAD_REQUEST = 400;
  static const AUTH_REQUIRED = 401;
  static const PERMISSION_DENIED = 403;
  static const NOT_FOUND = 404;
  static const NOT_ACCEPTABLE = 406;
  static const INTERNAL_SERVER_ERROR = 500;
  static const SERVICE_UNAVAILABLE = 503;
}
