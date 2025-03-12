import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../stream_widgets_models/stream_widget_client_model/stream_widget_client_model.dart';

class StreamWidgetMessageModel extends Equatable {
  final StreamWidgetClientModel clientData;

  const StreamWidgetMessageModel({
    required this.clientData,
  });

  @override
  List<Object?> get props => [
        clientData,
      ];

  Map<String, dynamic> toMap() => {
        'clientData': clientData.toMap(),
      };

  String toJson() => json.encode(
        toMap(),
      );
}
