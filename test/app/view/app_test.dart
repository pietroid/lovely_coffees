import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:my_app/root/root.dart';
import 'package:rxdart/subjects.dart';

class _MockFavoriteRepository extends Mock implements FavoritesRepository {}

void main() {
  late FavoritesRepository favoritesRepository;
  group('App', () {
    setUp(() {
      favoritesRepository = _MockFavoriteRepository();
      when(() => favoritesRepository.favorites)
          .thenAnswer((_) => BehaviorSubject.seeded([]));
    });
    testWidgets('renders Root', (tester) async {
      await tester.pumpWidget(
        App(
          favoritesRepository: favoritesRepository,
        ),
      );
      expect(find.byType(Root), findsOneWidget);
    });
  });
}
