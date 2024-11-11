// There is no good way to test isar currently, because it's very hard to mock.
// Below is an example of approach I tried, but unsuccessfully, because it
// depends on a private variable we can't access.
// There seems to be a way to test it, however, didn't see very maintanable
// for me as it requires actual initialization of isar
// That requires to know the path to be used in the database,
// which is not ideal for testing.
// Solution mentioned: https://github.com/isar/isar/issues/1147
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () {});
}

// import 'package:clock/clock.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:isar/isar.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:my_app/favorites/data/data_sources/favorites_data_source.dart';
// import 'package:my_app/favorites/data/models/favorite.dart';

// class _MockIsar extends Mock implements Isar {}

// class _MockIsarCollection extends Mock implements IsarCollection<Favorite> {}

// class _MockQueryBuilder extends Mock
//     implements QueryBuilder<Favorite, Favorite, QWhere> {}

// void main() {
//   late Isar isar;
//   late IsarCollection<Favorite> favoriteIsarCollection;
//   late QueryBuilder<Favorite, Favorite, QWhere> queryBuilder;

//   group('FavoritesDataSource', () {
//     setUp(() {
//       queryBuilder = _MockQueryBuilder();
//       when(() => queryBuilder.findAll()).thenAnswer((_) async => []);
//       when(() => queryBuilder.watch()).
//       thenAnswer((_) => const Stream.empty());

//       favoriteIsarCollection = _MockIsarCollection();
//       when(() => favoriteIsarCollection.where()).thenReturn(queryBuilder);
//       when(() => favoriteIsarCollection.put(any())).
//       thenAnswer((_) async => 0);
//       when(() => favoriteIsarCollection.delete(any()))
//           .thenAnswer((_) async => true);

//       isar = _MockIsar();
//       when(() => isar.favorites).thenReturn(favoriteIsarCollection);
//     });
//     test(
//         'fetchFavorites should return a list of favorites and call'
//         ' isar favorites',
//         () async {
//       when(() => queryBuilder.findAll()).thenAnswer((_) async => [
//             Favorite(pathToImage: 'img1', favoritedAt: clock.now()),
//             Favorite(pathToImage: 'img2', favoritedAt: clock.now()),
//           ]);

//       final favoritesDataSource = FavoritesDataSource(isar: isar);
//       final favorites = await favoritesDataSource.fetchFavorites();

//       expect(favorites.length, 2);
//       verify(() => isar.favorites.where().findAll()).called(1);
//     });
//   });
// }
