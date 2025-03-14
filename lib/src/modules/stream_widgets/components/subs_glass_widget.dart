import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/modules/stream_widgets/components/stream_widget.dart';

import '../../../app/widgets/widgets.dart';
import '../../../assets_gen/assets.gen.dart';
import '../controllers/controllers.dart';

class SubsGlassWidget extends StatefulWidget {
  final Function(String)? onTap;

  const SubsGlassWidget({
    super.key,
    this.onTap,
  });

  @override
  State<SubsGlassWidget> createState() => _SubsGlassWidgetState();
}

class _SubsGlassWidgetState extends State<SubsGlassWidget> {
  String _buttonTitle = 'Copy widget link';

  bool _copied = false;

  void _copyLink() {
    if (_copied) return;

    setState(
      () {
        _copied = true;
        _buttonTitle = 'Copied!';
        widget.onTap?.call('subs-glass');
      },
    );

    Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
      () => setState(
        () {
          _buttonTitle = 'Copy widget link';
          _copied = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SubsGlassWidgetController, SubsGlassWidgetState>(
        builder: (context, state) => StreamWidget(
          onTap: _copyLink,
          buttonTitle: _buttonTitle,
          title: 'Subs glass',
          widget: Stack(
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
      );
}
