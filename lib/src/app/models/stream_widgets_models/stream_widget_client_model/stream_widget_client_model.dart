import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'stream_widget_client_model.g.dart';

@JsonSerializable()
class StreamWidgetClient extends Equatable {
  final String id;
  final String name;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
    includeIfNull: false,
  )
  final WebSocketChannel? channel;

  const StreamWidgetClient({
    required this.id,
    required this.name,
    this.channel,
  });

  StreamWidgetClient copyWith({
    WebSocketChannel? channel,
  }) =>
      StreamWidgetClient(
        id: id,
        name: name,
        channel: channel,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        channel,
      ];

  factory StreamWidgetClient.fromJson(Map<String, dynamic> json) =>
      _$StreamWidgetClientFromJson(json);

  // factory StreamWidgetClient.fromJsonAndChannel(
  //   Map<String, dynamic> json,
  //   WebSocketChannel channel,
  // ) =>
  //     StreamWidgetClient.fromJson(
  //       json,
  //     ).copyWith(
  //       channel: channel,
  //     );
}
