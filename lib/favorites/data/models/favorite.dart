import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'favorite.g.dart';

@Collection()
@immutable
class Favorite {
  Favorite({
    required this.pathToImage,
    required this.favoritedAt,
  });

  Id id = Isar.autoIncrement;

  String pathToImage;

  DateTime favoritedAt;
}
