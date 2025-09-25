import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/state/remote_state.dart';

class PokemonListProvider extends ChangeNotifier {
  final PokemonService service;

  PokemonListProvider({required this.service});

  final int pageSize = 10;

  RemoteState _remoteState = RemoteStateNone();

  RemoteState get remoteState => _remoteState;

  int _pageCount = 0;

  int get pageCount => _pageCount;

  final List<Result> _pokemonList = [];

  List<Result> get pokemonList => _pokemonList;

  Future<void> fetchPokemonList() async {
    try {
      _remoteState = RemoteStateLoading();
      notifyListeners();

      final result = await service.fetchPokemonList(
        limit: pageSize,
        offset: pageCount * pageSize,
      );

      switch (result) {
        case RemoteStateSuccess<Pokemon>(data: var data):
          _pageCount = pageCount + 1;
          _pokemonList.addAll(data.results);
          _remoteState = RemoteStateSuccess(pokemonList);
          // notifyListeners();
          break;
        case RemoteStateError(error: var message):
          _remoteState = RemoteStateError(message);
          // notifyListeners();
          break;
        default:
          _remoteState = RemoteStateNone();
          // notifyListeners();
          break;
      }
      notifyListeners();
    } on Exception catch (e) {
      _remoteState = RemoteStateError(e.toString());
      notifyListeners();
    }
  }
}
