// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_widget_client_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamWidgetClientResponseDto _$StreamWidgetClientResponseDtoFromJson(
        Map<String, dynamic> json) =>
    StreamWidgetClientResponseDto(
      clientData: StreamWidgetClient.fromJson(
          json['clientData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamWidgetClientResponseDtoToJson(
        StreamWidgetClientResponseDto instance) =>
    <String, dynamic>{
      'clientData': instance.clientData,
    };
