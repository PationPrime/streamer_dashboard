import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subs_glass_ball_model.g.dart';

@JsonSerializable()
class SubsGlassBallModel extends Equatable {
  final double radius;
  final List<int>? bytesImage;
  final String imageUrl;

  const SubsGlassBallModel({
    required this.radius,
    required this.imageUrl,
    this.bytesImage,
  });

  @override
  List<Object?> get props => [
        radius,
        bytesImage,
        imageUrl,
      ];

  Map<String, dynamic> toJson() => _$SubsGlassBallModelToJson(
        this,
      );

  factory SubsGlassBallModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SubsGlassBallModelFromJson(
        json,
      );
}
