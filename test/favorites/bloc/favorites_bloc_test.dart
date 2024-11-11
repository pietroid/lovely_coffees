import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/bloc/favorites_bloc.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:rxdart/subjects.dart';

class _MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  final favoriteFake = Favorite(
    pathToImage: 'fakePath',
    favoritedAt: clock.now(),
  );

  late FavoritesRepository favoritesRepository;

  group('FavoritesBloc', () {
    setUp(() {
      favoritesRepository = _MockFavoritesRepository();
      when(() => favoritesRepository.favorites)
          .thenAnswer((_) => BehaviorSubject.seeded([]));
    });
    blocTest<FavoritesBloc, FavoritesState>(
      'when FavoritesLoad is added, it should start listening to favorites',
      build: () => FavoritesBloc(
        favoritesRepository: favoritesRepository,
      ),
      act: (bloc) => bloc.add(FavoritesLoad()),
      verify: (_) {
        verify(() => favoritesRepository.favorites).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'when FavoritesUpdate is added, it should emit FavoritesSuccess',
      build: () => FavoritesBloc(
        favoritesRepository: favoritesRepository,
      ),
      act: (bloc) => bloc.add(FavoritesUpdate(favorites: [favoriteFake])),
      expect: () => <FavoritesState>[
        FavoritesSuccess(favorites: [favoriteFake])
      ],
    );
  });
}
