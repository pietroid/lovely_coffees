import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class DiscoverDataSource {
  DiscoverDataSource({
    required this.client,
    required this.baseUrl,
  });

  final http.Client client;
  final String baseUrl;

  Future<String> fetchRandomCoffeeImageUrl() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch random coffee image');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['file'] as String;
  }

  Future<Uint8List> fetchCoffeeImage(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch coffee image');
    }

    return response.bodyBytes;
  }
}
