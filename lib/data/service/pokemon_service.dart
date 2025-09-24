import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/model/pokemon_detail.dart';
import 'package:pokemon/data/network/dio_api_client.dart';
import 'package:pokemon/data/state/remote_state.dart';

class PokemonService {
  final client = DioApiClient();

  Future<RemoteState> fetchPokemonList({int limit = 10, int offset = 0}) async {
    try {
      final response = await client.dio.get(
        '',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      if (response.statusCode == 200) {
        final pokemonList = Pokemon.fromJson(response.data);

        return RemoteStateSuccess<Pokemon>(pokemonList);
      } else {
        return RemoteStateError(response.toString());
      }
    } catch (e) {
      return RemoteStateError('Failed to load data: ${e.toString()}');
    }
  }

  Future<RemoteState> getPokemonDetail({required int id}) async {
    try {
      final response = await DioApiClient().dio.get('/$id');

      if (response.statusCode == 200) {
        final pokemonDetail = PokemonDetail.fromJson(response.data);

        return RemoteStateSuccess<PokemonDetail>(pokemonDetail);
      } else {
        return RemoteStateError(response.toString());
      }
    } catch (e) {
      return RemoteStateError('Failed to load data: ${e.toString()}');
    }
  }
}
