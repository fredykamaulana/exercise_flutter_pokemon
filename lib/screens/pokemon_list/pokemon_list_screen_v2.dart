import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:pokemon/data/state/remote_state.dart';
import 'package:pokemon/screens/pokemon_list/pokemon_card.dart';
import 'package:pokemon/screens/pokemon_list/provider/pokemon_list_provider.dart';
import 'package:provider/provider.dart';

class PokemonListScreenV2 extends StatefulWidget {
  const PokemonListScreenV2({super.key});

  @override
  State<PokemonListScreenV2> createState() => _PokemonListScreenV2State();
}

class _PokemonListScreenV2State extends State<PokemonListScreenV2> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMorePokemon);

    context.read<PokemonListProvider>().fetchPokemonList();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMorePokemon() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      dev.log('Loading more pokemons...');
      context.read<PokemonListProvider>().fetchPokemonList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          int currentCrossAxisCount = 2; // Default value
          if (constraints.maxWidth > 400) {
            currentCrossAxisCount = constraints.maxWidth ~/ 200;
          }

          return Consumer<PokemonListProvider>(
            builder: (context, provider, child) {
              print('list: ${provider.pokemonList.toString()}');
              print('state: ${provider.remoteState.toString()}');
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pokelite',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Known your favorite pokemon',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: GridView.builder(
                        shrinkWrap: true, // Important for nested scrollables
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: currentCrossAxisCount,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          //childAspectRatio:0.7,
                        ),
                        itemCount: provider.pokemonList.length,
                        itemBuilder: (context, index) {
                          return PokemonCard(
                            pokemon: provider.pokemonList[index],
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: switch (provider.remoteState) {
                        RemoteStateLoading() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        RemoteStateError(error: var error) => Center(
                          child: Text("Error loading movies: $error"),
                        ),
                        _ => const SizedBox.shrink(),
                      },
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 16)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
