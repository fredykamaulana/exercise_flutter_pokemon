import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon_detail.dart';
import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/state/remote_state.dart';

class PokemonDetailProvider extends ChangeNotifier {
  final PokemonService service;

  PokemonDetailProvider({required this.service});

  RemoteState _remoteState = RemoteStateNone();
  RemoteState get remoteState => _remoteState;

  PokemonDetail? _pokemonDetail;
  PokemonDetail? get pokemonDetail => _pokemonDetail;

  Future<void> fetchPokemonDetail(int id) async {
    try {
      _remoteState = RemoteStateLoading();
      notifyListeners();

      final response = await service.getPokemonDetail(id: id);

      switch (response) {
        case RemoteStateSuccess<PokemonDetail>(data: var data):
          _remoteState = RemoteStateSuccess<PokemonDetail>(data);
          _pokemonDetail = response.data;
          break;
        case RemoteStateError(error: var message):
          _remoteState = RemoteStateError(message);
          break;
        default:
          _remoteState = RemoteStateNone();
          break;
      }
      notifyListeners();
    } catch (e) {
      _remoteState = RemoteStateError(e.toString());
      notifyListeners();
    }
  }
}
