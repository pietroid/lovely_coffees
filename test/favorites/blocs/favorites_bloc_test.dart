import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffees/favorites/blocs/favorites/favorites_bloc.dart';
import 'package:lovely_coffees/favorites/data/models/favorite.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:mocktail/mocktail.dart';
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
      'when FavoritesLoad is added, it should start listening to favorites and '
      'should call favoritesRepository.init',
      build: () => FavoritesBloc(
        favoritesRepository: favoritesRepository,
      ),
      act: (bloc) => bloc.add(FavoritesLoad()),
      verify: (_) {
        verify(() => favoritesRepository.favorites).called(1);
        verify(() => favoritesRepository.init()).called(1);
      },
    );

    group('favoritesUpdate', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'when FavoritesUpdate is added and list is not empty, '
        'it should emit FavoritesSuccess',
        build: () => FavoritesBloc(
          favoritesRepository: favoritesRepository,
        ),
        act: (bloc) => bloc.add(FavoritesUpdate(favorites: [favoriteFake])),
        expect: () => <FavoritesState>[
          FavoritesSuccess(favorites: [favoriteFake]),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'when FavoritesUpdate is added and list is empty, '
        'it should emit FavoritesEmpty',
        build: () => FavoritesBloc(
          favoritesRepository: favoritesRepository,
        ),
        act: (bloc) => bloc.add(FavoritesUpdate(favorites: const [])),
        expect: () => <FavoritesState>[
          FavoritesEmpty(),
        ],
      );
    });
  });
}
