import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/discover/data/models/coffee_image.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/discover/view/discover_carousel_item.dart';
import 'package:my_app/discover/view/discover_page.dart';

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
