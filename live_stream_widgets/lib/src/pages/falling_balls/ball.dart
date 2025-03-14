part of 'falling_balls.dart';

class Ball {
  final double radius;
  Offset position;
  Offset velocity;

  final String imageUrl;

  ui.Image? image;

  final List<int>? imageBytes;

  /// Approximate ball mass
  double get mass => radius.pow2().toDouble() * pi;

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.imageUrl,
    this.imageBytes,
  }) {
    _convertImage();
  }

  Future<void> _loadImageFromBytes() async {
    if (imageBytes is! List<int>) return;

    final completer = Completer<ui.Image>();

    final uni8List = Uint8List.fromList(imageBytes!);

    ui.decodeImageFromList(
      uni8List,
      (ui.Image img) => completer.complete(
        img,
      ),
    );

    image = await completer.future;
  }

  Future<void> _loadImage() async {
    final stream = NetworkImage(imageUrl).resolve(ImageConfiguration());
    final completer = Completer<ui.Image>();

    stream.addListener(
      ImageStreamListener(
        (imageInfo, synchronousCall) => completer.complete(
          imageInfo.image,
        ),
      ),
    );

    image = await completer.future;
  }

  Future<void> _convertImage() async {
    if (imageBytes is List<int>) {
      return await _loadImageFromBytes();
    }

    return await _loadImage();
  }
}
