import 'dart:convert';

import 'package:flutter/services.dart';

abstract final class AppAdditionalData {
  static Future<List<Map<String, dynamic>>> readJsonFileFromAsset(
    String assetPath,
  ) async {
    final response = await rootBundle.loadString(assetPath);
    final data = await json.decode(response);

    final dataResponse = (data as List)
        .map(
          (item) => item as Map<String, dynamic>,
        )
        .toList();

    return dataResponse;
  }
}
