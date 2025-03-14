import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_stream_widgets/src/app/models/models.dart';

part 'subs_glass_balls_response_dto.g.dart';

@JsonSerializable()
class SubsGlassBallsResponseDto extends Equatable {
  final List<SubsGlassBallModel> balls;

  const SubsGlassBallsResponseDto({
    required this.balls,
  });

  @override
  List<Object?> get props => [
        balls,
      ];

  factory SubsGlassBallsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SubsGlassBallsResponseDtoFromJson(
        json,
      );

  Map<String, dynamic> toJson() => _$SubsGlassBallsResponseDtoToJson(
        this,
      );
}
