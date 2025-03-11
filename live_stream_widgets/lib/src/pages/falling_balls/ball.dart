part of 'falling_balls.dart';

class Ball {
  final double radius;
  Offset position;
  Offset velocity;

  final String imageUrl;
  ui.Image? image;

  /// Approximate ball mass
  double get mass => radius.pow2().toDouble() * pi;

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.imageUrl,
  }) {
    _loadImage();
  }

  Future<void> _loadImage() async {
    final stream = NetworkImage(imageUrl).resolve(ImageConfiguration());
    final completer = Completer<ui.Image>();

    stream.addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        completer.complete(imageInfo.image);
      }),
    );

    image = await completer.future;
  }

  /// Unit8List Image
  //  Future<void> _loadNetworkImage(String url) async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final Uint8List bytes = response.bodyBytes;

  //     final Completer<ui.Image> completer = Completer();
  //     ui.decodeImageFromList(bytes, (ui.Image img) {
  //       completer.complete(img);
  //     });

  //     _image = await completer.future;
  //   } catch (e) {
  //     print("Ошибка загрузки изображения: $e");
  //   }
  // }
}
