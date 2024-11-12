import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/data/data_sources/favorites_image_data_source.dart';

import '../../../helpers/shared_fixtures.dart';

class _MockFile extends Mock implements File {}

void main() {
  late File file;
  group('FavoritesImageDataSource', () {
    setUp(() {
      file = _MockFile();
    });
    test(
        'when fetchImageWithPath is called, it should return an image and call readAsBytes',
        () {
      when(() => file.readAsBytes()).thenAnswer((_) async => fakeImage);

      IOOverrides.runZoned(() async {
        final dataSource =
            FavoritesImageDataSource(applicationDirectory: fakeRootPath);
        final image = await dataSource.fetchImageWithPath(fakeImageName);

        verify(() => file.readAsBytes()).called(1);
        expect(image, fakeImage);
      }, createFile: (String path) => file);
    });

    test('when saveImageWithPath is called, it call writeAsBytes', () {
      final fileMock = _MockFile();

      when(() => fileMock.writeAsBytes(fakeImage))
          .thenAnswer((_) async => fileMock);

      IOOverrides.runZoned(() async {
        final dataSource =
            FavoritesImageDataSource(applicationDirectory: fakeRootPath);
        await dataSource.saveImageWithPath(fakeImageName, fakeImage);

        verify(() => fileMock.writeAsBytes(fakeImage)).called(1);
      }, createFile: (String path) => file);
    });
  });
}
