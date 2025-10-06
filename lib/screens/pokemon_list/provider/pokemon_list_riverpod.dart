import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/state/remote_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list_riverpod.g.dart';

final int pageSize = 10;

@riverpod
PokemonService pokemonService(Ref ref) {
  return PokemonService();
}

@riverpod
int pageCount(Ref ref) {
  return 0;
}

@riverpod
Future<RemoteState> getPokemonList(Ref ref) async {
  final service = ref.watch(pokemonServiceProvider);
  final page = ref.watch(pageCountProvider);

  return await service.fetchPokemonList(
    limit: pageSize,
    offset: page * pageSize,
  );
}
