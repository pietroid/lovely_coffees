import 'dart:typed_data';

class CoffeeImage {
  const CoffeeImage({
    required this.url,
    required this.image,
  });

  final String url;
  final Uint8List image;
}
