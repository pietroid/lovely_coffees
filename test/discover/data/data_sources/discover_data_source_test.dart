import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:my_app/discover/data/data_sources/discover_data_source.dart';

class _MockHttpClient extends Mock implements http.BaseClient {}

void main() {
  late http.Client client;
  group('DiscoverDataSource', () {
    setUp(() {
      client = _MockHttpClient();
    });

    test('fetchRandomCoffeeImageUrl', () async {
      const baseUrl = 'https://example.com';
      final dataSource = DiscoverDataSource(
        client: client,
        baseUrl: baseUrl,
      );

      when(() => client.get(Uri.parse(baseUrl))).thenAnswer(
        (_) => Future.value(http.Response('{"file": "url"}', 200)),
      );

      final url = await dataSource.fetchRandomCoffeeImageUrl();
      expect(url, 'url');
    });

    test('fetchCoffeeImage', () async {
      const anyImage = 'https://anyimage.com';
      final dataSource = DiscoverDataSource(
        client: client,
        baseUrl: 'https://example.com',
      );

      when(() => client.get(Uri.parse(anyImage))).thenAnswer(
        (_) => Future.value(http.Response.bytes([0, 1, 2, 3], 200)),
      );

      final image = await dataSource.fetchCoffeeImage(anyImage);
      expect(image, [0, 1, 2, 3]);
    });

    group('error cases', () {
      test('fetchRandomCoffeeImageUrl', () async {
        const baseUrl = 'https://example.com';
        final dataSource = DiscoverDataSource(
          client: client,
          baseUrl: baseUrl,
        );

        when(() => client.get(Uri.parse(baseUrl))).thenAnswer(
          (_) => Future.value(http.Response('Not Found', 404)),
        );

        expect(
          () async => dataSource.fetchRandomCoffeeImageUrl(),
          throwsException,
        );
      });

      test('fetchCoffeeImage', () async {
        const anyImage = 'https://anyimage.com';
        final dataSource = DiscoverDataSource(
          client: client,
          baseUrl: 'https://example.com',
        );

        when(() => client.get(Uri.parse(anyImage))).thenAnswer(
          (_) => Future.value(http.Response('Not Found', 404)),
        );

        expect(
          () async => dataSource.fetchCoffeeImage(anyImage),
          throwsException,
        );
      });
    });
  });
}
