import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/models.dart';

part 'stream_widget_client_response_dto.g.dart';

@JsonSerializable()
class StreamWidgetClientResponseDto extends Equatable {
  final StreamWidgetClient clientData;

  const StreamWidgetClientResponseDto({
    required this.clientData,
  });

  @override
  List<Object?> get props => [
        clientData,
      ];

  factory StreamWidgetClientResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$StreamWidgetClientResponseDtoFromJson(json);
}
