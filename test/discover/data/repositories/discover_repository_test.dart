import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/discover/data/data_sources/discover_data_source.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';

class _MockDiscoverDataSource extends Mock implements DiscoverDataSource {}

void main() {
  const fakeImageUrl = 'imageUrl';
  final fakeImage = Uint8List(0);

  late DiscoverDataSource dataSource;
  group('DiscoverRepositoryTest', () {
    setUp(() {
      dataSource = _MockDiscoverDataSource();
    });
    test(
        'fetchRandomCoffeeImage should return coffeeImage '
        'with fakeImageUrl and fakeImage', () async {
      when(() => dataSource.fetchRandomCoffeeImageUrl())
          .thenAnswer((_) async => fakeImageUrl);
      when(() => dataSource.fetchCoffeeImage(fakeImageUrl))
          .thenAnswer((_) async => fakeImage);

      final coffeeImage = await DiscoverRepository(dataSource: dataSource)
          .fetchRandomCoffeeImage();

      expect(coffeeImage.url, fakeImageUrl);
      expect(coffeeImage.image, fakeImage);
    });

    test(
        'fetchRandomCoffeeImage should throw CoffeImageException when there is '
        'error on some fetchRandomCoffeeImageUrl request', () async {
      when(() => dataSource.fetchRandomCoffeeImageUrl()).thenThrow(Exception());
      when(() => dataSource.fetchCoffeeImage(fakeImageUrl))
          .thenAnswer((_) async => fakeImage);

      expect(
        () async =>
            DiscoverRepository(dataSource: dataSource).fetchRandomCoffeeImage(),
        throwsA(isA<CoffeImageException>()),
      );
    });

    test(
        'fetchRandomCoffeeImage should throw CoffeImageException when there is '
        'error on some fetchCoffeeImage request', () async {
      when(() => dataSource.fetchRandomCoffeeImageUrl())
          .thenAnswer((_) async => fakeImageUrl);
      when(() => dataSource.fetchCoffeeImage(fakeImageUrl))
          .thenThrow(Exception());

      expect(
        () async =>
            DiscoverRepository(dataSource: dataSource).fetchRandomCoffeeImage(),
        throwsA(isA<CoffeImageException>()),
      );
    });
  });
}
