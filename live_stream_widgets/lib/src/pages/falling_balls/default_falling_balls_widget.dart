import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bridge_server_controller/bridge_server_controller.dart';
import '../../assets_gen/assets.gen.dart';
import 'falling_balls.dart';

class DefaultFallingBallsWidget extends StatefulWidget {
  const DefaultFallingBallsWidget({super.key});

  @override
  State<DefaultFallingBallsWidget> createState() =>
      _DefaultFallingBallsWidgetState();
}

class _DefaultFallingBallsWidgetState extends State<DefaultFallingBallsWidget> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BridgeServerController, BridgeServerState>(
        builder: (context, bridgeServerState) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      child: SizedBox(
                        height: 400,
                        width: 250,
                        child: FallingBalls(
                          bottomMargin: 45,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      child: Image.asset(
                        Assets.images.plasticTransparentCup.path,
                        height: 400,
                        width: 350,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'bridgeServerUrl: ${bridgeServerState.bridgeServerUrl}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      );
}
