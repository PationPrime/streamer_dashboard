import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';

part 'subs_glass_message_dto.g.dart';

@JsonSerializable(
  createFactory: false,
)
class SubsGlassMessageDto extends Equatable {
  final List<SubsGlassBallModel> balls;

  const SubsGlassMessageDto({
    required this.balls,
  });

  @override
  List<Object?> get props => [
        balls,
      ];

  Map<String, dynamic> toMap() => _$SubsGlassMessageDtoToJson(
        this,
      );

  String toJson() => jsonEncode(
        toMap(),
      );
}
