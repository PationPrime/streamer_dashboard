// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

const String NO_AUTH_EXTRA = "no-auth";

const noAuthExtra = {
  NO_AUTH_EXTRA: true,
};

final noAuthOptions = Options(
  extra: noAuthExtra,
);
