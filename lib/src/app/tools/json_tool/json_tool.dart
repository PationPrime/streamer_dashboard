import 'dart:convert';
import 'dart:io';

abstract final class JsonTool {
  static Future<T?> readJsonFileFromAsset<T>(
    String filePath, {
    String? jsonRootKey,
  }) async {
    final rawData = await File(filePath).readAsString();
    final rawJSON = jsonDecode(rawData);

    final data = jsonRootKey != null ? rawJSON[jsonRootKey] : rawJSON;

    if (data is List) {
      return data
          .map(
            (item) => item as Map<String, dynamic>,
          )
          .toList() as T;
    } else if (data is Map) {
      return data as T;
    } else {
      throw Exception(
        'Unsupported type. <T> must be List or Map data type',
      );
    }
  }
}
