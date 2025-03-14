// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subs_glass_balls_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubsGlassBallsResponseDto _$SubsGlassBallsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    SubsGlassBallsResponseDto(
      balls: (json['balls'] as List<dynamic>)
          .map((e) => SubsGlassBallModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubsGlassBallsResponseDtoToJson(
        SubsGlassBallsResponseDto instance) =>
    <String, dynamic>{
      'balls': instance.balls,
    };
