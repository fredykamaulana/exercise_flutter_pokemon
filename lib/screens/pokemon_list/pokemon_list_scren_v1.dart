import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/state/remote_state.dart';
import 'package:pokemon/screens/pokemon_list/pokemon_card.dart';
import 'package:pokemon/screens/pokemon_list/provider/pokemon_list_riverpod.dart';

class PokemonListScreenV1 extends ConsumerStatefulWidget {
  const PokemonListScreenV1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListScreenV1State();
}

class _PokemonListScreenV1State extends ConsumerState<PokemonListScreenV1> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMorePokemon);

    ref.read(getPokemonListProvider);
    super.initState();
  }

  void _loadMorePokemon() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('loading more pokemon...');
      ref.read(getPokemonListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListAsync = ref.watch(getPokemonListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: pokemonListAsync.when(
        data: (data) {
          ref.read(pageCountProvider) + 1;
          return switch (data) {
            RemoteStateSuccess<Pokemon>(data: var data) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: data.results.length,
                itemBuilder: (context, index) {
                  final pokemon = data.results[index];
                  return PokemonCard(pokemon: pokemon);
                },
              ),
            ),
            RemoteStateError(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox.shrink(),
          };
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
