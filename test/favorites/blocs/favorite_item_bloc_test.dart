import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/blocs/favorite_item/favorite_item_bloc.dart';
import 'package:my_app/favorites/data/repositories/favorite_item_repository.dart';

import '../../helpers/shared_fixtures.dart';

class _MockFavoriteItemRepository extends Mock
    implements FavoriteItemRepository {}

void main() {
  late FavoriteItemRepository favoriteItemRepository;
  group('FavoriteItemBloc', () {
    setUp(() {
      favoriteItemRepository = _MockFavoriteItemRepository();
      when(() => favoriteItemRepository.fetchImageWithPath(fakeImageName))
          .thenAnswer((_) => Future.value(fakeImage));
    });
    blocTest<FavoriteItemBloc, FavoriteItemState>(
      'when FavoriteItemLoad is added, it should emit FavoriteItemLoaded',
      build: () => FavoriteItemBloc(
        favoriteItemRepository: favoriteItemRepository,
      ),
      act: (bloc) => bloc.add(FavoriteItemLoad(name: fakeImageName)),
      expect: () => <FavoriteItemState>[
        FavoriteItemLoaded(image: fakeImage),
      ],
      verify: (_) {
        verify(() => favoriteItemRepository.fetchImageWithPath(fakeImageName))
            .called(1);
      },
    );
  });
}
