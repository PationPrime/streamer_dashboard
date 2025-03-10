import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/bridge_server_controller/bridge_server_controller.dart';

class Welcome extends StatefulWidget {
  final String bridgeUrl;

  const Welcome({
    super.key,
    required this.bridgeUrl,
  });

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();

    context.read<BridgeServerController>().setBridgeServerUri(
          widget.bridgeUrl,
        );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BridgeServerController, BridgeServerState>(
        builder: (context, bridgeServerState) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: bridgeServerState.loading
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to Stream Widgets!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (bridgeServerState.errorMessage is String)
                            Text(
                              bridgeServerState.errorMessage!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          else
                            Text(
                              'bridgeUrl: ${bridgeServerState.bridgeServerUrl}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(
                            height: 100,
                          ),
                          MaterialButton(
                            onPressed: () {
                              context.go('/subs-glass');
                            },
                            child: Text(
                              'Navigate',
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      );
}
