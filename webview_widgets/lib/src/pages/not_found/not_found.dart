import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_widgets/src/assets_gen/assets.gen.dart';

class NotFound404 extends StatelessWidget {
  const NotFound404({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: 300,
            child: LottieBuilder(
              lottie: AssetLottie(
                Assets.lottie.pageNotFound404,
              ),
            ),
          ),
        ),
      );
}
