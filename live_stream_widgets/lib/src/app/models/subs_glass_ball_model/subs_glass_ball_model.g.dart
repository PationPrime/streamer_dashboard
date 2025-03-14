// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subs_glass_ball_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubsGlassBallModel _$SubsGlassBallModelFromJson(Map<String, dynamic> json) =>
    SubsGlassBallModel(
      radius: (json['radius'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      bytesImage: (json['bytesImage'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$SubsGlassBallModelToJson(SubsGlassBallModel instance) =>
    <String, dynamic>{
      'radius': instance.radius,
      'bytesImage': instance.bytesImage,
      'imageUrl': instance.imageUrl,
    };
