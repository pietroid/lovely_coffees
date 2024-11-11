import 'package:isar/isar.dart';

part 'favorite.g.dart';

@Collection()
class Favorite {
  Favorite({
    required this.pathToImage,
    required this.favoritedAt,
  });

  Id id = Isar.autoIncrement;

  String pathToImage;

  DateTime favoritedAt;
}
