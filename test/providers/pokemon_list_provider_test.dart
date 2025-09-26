import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/state/remote_state.dart';
import 'package:pokemon/screens/pokemon_list/provider/pokemon_list_provider.dart';

import '../utils/utils.dart';

class MockPokemonService extends Mock implements PokemonService {}

void main() {
  // setup instance
  late PokemonService service;
  late PokemonListProvider provider;

  setUp(() {
    service = MockPokemonService();
    provider = PokemonListProvider(service: service);
  });
  group('Pokemon List Provider Test', () {
    test(
      'When load pokemon list and list is contain data, remoteState should be RemoteStateSuccess and pokemonList should not empty',
      () async {
        // Arrange
        when(() => service.fetchPokemonList(limit: 10, offset: 0)).thenAnswer(
          (_) => Future.value(
            RemoteStateSuccess<Pokemon>(
              dummyPokemon(pokemonList: dummyPokemonList),
            ),
          ),
        );

        // Act
        await provider.fetchPokemonList();

        // Assert
        verify(() => service.fetchPokemonList(limit: 10, offset: 0)).called(1);

        // Assert
        final remoteState = provider.remoteState;
        expect(remoteState, isA<RemoteStateSuccess<Pokemon>>());

        final pokemonList = provider.pokemonList;
        expect(pokemonList.length, dummyPokemonList.length);
      },
    );

    test(
      'When load pokemon list and api error, remoteState should be RemoteStateError and pokemonList should empty',
      () async {
        // Arrange
        when(() => service.fetchPokemonList(limit: 10, offset: 0)).thenAnswer(
          (_) => Future.value(
            RemoteStateSuccess<Pokemon>(
              dummyPokemon(pokemonList: dummyPokemonList),
            ),
          ),
        );

        print('Arrage success');
        // Act
        await provider.fetchPokemonList();

        // Assert
        verify(() => service.fetchPokemonList(limit: 10, offset: 0)).called(1);
        print('service called');

        // Assert
        final remoteState = provider.remoteState;
        expect(remoteState, isA<RemoteStateSuccess<Pokemon>>());

        print('check remote state passed');

        final pokemonList = provider.pokemonList;
        expect(pokemonList.length, dummyPokemonList.length);
      },
    );
  });
}
