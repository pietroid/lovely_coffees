import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/discover/bloc/discover_bloc.dart';
import 'package:my_app/discover/data/models/coffee_image.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';

class _MockDiscoverRepository extends Mock implements DiscoverRepository {}

void main() {
  final fakeImage = Uint8List(0);

  late DiscoverRepository repository;

  group('DiscoverBloc', () {
    setUp(() {
      repository = _MockDiscoverRepository();
      when(() => repository.fetchRandomCoffeeImage()).thenAnswer(
        (_) => Future.value(
          CoffeeImage(
            url: 'url',
            image: fakeImage,
          ),
        ),
      );
    });
    blocTest<DiscoverBloc, DiscoverState>(
      'emits [DiscoverLoaded] when DiscoverLoad is added',
      build: () => DiscoverBloc(
        repository: repository,
      ),
      act: (bloc) => bloc.add(DiscoverLoad()),
      expect: () => [
        DiscoverLoaded(
          name: 'url',
          image: fakeImage,
        ),
      ],
      verify: (bloc) =>
          verify(() => repository.fetchRandomCoffeeImage()).called(1),
    );

    blocTest<DiscoverBloc, DiscoverState>(
      'emits [DiscoverFailure] when DiscoverLoad is added and repository throws',
      build: () {
        when(() => repository.fetchRandomCoffeeImage()).thenThrow(Exception());
        return DiscoverBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(DiscoverLoad()),
      expect: () => [
        DiscoverFailure(),
      ],
      verify: (bloc) =>
          verify(() => repository.fetchRandomCoffeeImage()).called(1),
    );
  });
}
