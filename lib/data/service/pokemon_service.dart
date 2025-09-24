import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/network/http_api_client.dart';
import 'package:pokemon/data/state/remote_state.dart';

class PokemonService {
  final http = HttpApiClient();

  Future<RemoteState> fetchPokemonList({int limit = 10, int offset = 0}) async {
    try {
      final response = await http.client.get(
        Uri.parse('${http.baseUrl}?limit=50&offset=0'),
      );

      if (response.statusCode == 200) {
        print(response.body);

        final pokemonData = pokemonFromJson(response.body);

        return RemoteStateSuccess<Pokemon>(pokemonData);
      } else {
        return RemoteStateError(response.toString());
      }
    } catch (e) {
      return RemoteStateError('Failed to load data: ${e.toString()}');
    }
  }
}
