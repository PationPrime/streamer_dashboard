import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_stream_widgets/src/app/subs_glass_widget_controller/subs_glass_widget_controller.dart';
import 'package:uuid/uuid.dart';

import '../../app/bridge_server_controller/bridge_server_controller.dart';
import '../../app/models/stream_widgets_models/stream_widget_client_model/stream_widget_client_model.dart';
import '../../assets_gen/assets.gen.dart';
import 'falling_balls.dart';

class DefaultFallingBallsWidget extends StatefulWidget {
  final String bridgeUrl;

  const DefaultFallingBallsWidget({
    super.key,
    required this.bridgeUrl,
  });

  @override
  State<DefaultFallingBallsWidget> createState() =>
      _DefaultFallingBallsWidgetState();
}

class _DefaultFallingBallsWidgetState extends State<DefaultFallingBallsWidget> {
  @override
  void initState() {
    super.initState();

    context.read<BridgeServerController>().setBridgeServerUriAndClientData(
          widget.bridgeUrl,
          StreamWidgetClientModel(
            id: Uuid().v4(),
            name: 'Subs Glass',
          ),
        );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BridgeServerController, BridgeServerState>(
        builder: (context, bridgeServerState) =>
            BlocBuilder<SubsGlassWidgetController, SubsGlassWidgetState>(
          builder: (context, subsGlassWidgetState) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: bridgeServerState.loading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Center(
                                    child: SizedBox(
                                      height: 400,
                                      width: 250,
                                      child: FallingBalls(
                                        bottomMargin: 45,
                                        subsGlassBallModels:
                                            subsGlassWidgetState
                                                .subsGlassModels,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: 70,
                                  right: 5,
                                  child: Center(
                                    child: Image.asset(
                                      Assets.images.plasticTransparentCup.path,
                                      height: 400,
                                      width: 350,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );
}
