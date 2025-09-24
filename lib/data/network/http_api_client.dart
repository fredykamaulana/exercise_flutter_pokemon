import 'package:http/http.dart' as http;

// const String imageUrl =
//     'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

String provideImageUrl(int id) =>
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

class HttpApiClient {
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  late final http.Client _client;
  http.Client get client => _client;

  static final HttpApiClient _instance = HttpApiClient._internal();
  factory HttpApiClient() {
    return _instance;
  }
  HttpApiClient._internal() {
    _client = http.Client();
  }
}
