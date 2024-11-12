import 'dart:io';
import 'dart:typed_data';

class FavoritesImageDataSource {
  FavoritesImageDataSource({
    required this.applicationDirectory,
  });

  final String applicationDirectory;

  Future<void> saveImageWithPath(
    String path,
    Uint8List image,
  ) async {
    final file = File('$applicationDirectory/$path');
    await file.writeAsBytes(image);
  }

  Future<Uint8List> fetchImageWithPath(
    String path,
  ) async {
    final file = File('$applicationDirectory/$path');
    return file.readAsBytes();
  }
}
