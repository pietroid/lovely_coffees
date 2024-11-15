import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffees/discover/data/models/coffee_image.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/discover/view/discover_page.dart';
import 'package:lovely_coffees/discover/view/widgets/discover_carousel_item.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockDisoverRepository extends Mock implements DiscoverRepository {}

void main() {
  late DiscoverRepository discoverRepository;
  group('DiscoverPageTest', () {
    setUp(() {
      discoverRepository = _MockDisoverRepository();
      when(() => discoverRepository.fetchRandomCoffeeImage()).thenAnswer(
        (_) => Future.value(
          CoffeeImage(
            url: 'url',
            image: Uint8List(0),
          ),
        ),
      );
    });
    testWidgets('should render DiscoverCarouselItem', (tester) async {
      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DiscoverRepository>(
              create: (context) => discoverRepository,
            ),
          ],
          child: const DiscoverPage(),
        ),
      );

      expect(find.byType(DiscoverCarouselItem), findsAny);
    });
  });
}
