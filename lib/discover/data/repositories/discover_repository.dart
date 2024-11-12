import 'package:lovely_coffees/discover/data/data_sources/discover_data_source.dart';
import 'package:lovely_coffees/discover/data/models/coffee_image.dart';

class DiscoverRepository {
  DiscoverRepository({
    required this.dataSource,
  });

  final DiscoverDataSource dataSource;

  Future<CoffeeImage> fetchRandomCoffeeImage() async {
    try {
      final url = await dataSource.fetchRandomCoffeeImageUrl();
      final image = await dataSource.fetchCoffeeImage(url);
      return CoffeeImage(url: url, image: image);
    } catch (e) {
      throw CoffeImageException();
    }
  }
}

class CoffeImageException implements Exception {}
