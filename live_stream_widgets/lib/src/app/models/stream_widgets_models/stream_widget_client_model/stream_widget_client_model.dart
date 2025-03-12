import 'dart:convert';

import 'package:equatable/equatable.dart';

class StreamWidgetClientModel extends Equatable {
  final String id;
  final String name;

  const StreamWidgetClientModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => json.encode(
        toMap(),
      );
}
