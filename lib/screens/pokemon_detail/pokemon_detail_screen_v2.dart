import 'package:flutter/material.dart';
import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/state/remote_state.dart';
import 'package:pokemon/screens/pokemon_detail/pokemon_detail_content.dart';
import 'package:pokemon/screens/pokemon_detail/provider/pokemon_detail_provider.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreenV2 extends StatefulWidget {
  final int pokemonId;

  const PokemonDetailScreenV2({super.key, required this.pokemonId});

  @override
  State<PokemonDetailScreenV2> createState() => _PokemonDetailScreenV2State();
}

class _PokemonDetailScreenV2State extends State<PokemonDetailScreenV2> {
  final PokemonService service = PokemonService();

  @override
  void initState() {
    // context.read<PokemonDetailBloc>().add(
    //   FetchPokemonDetail(pokemonId: widget.pokemonId),
    // );

    Future.microtask(() {
      context.read<PokemonDetailProvider>().fetchPokemonDetail(
        widget.pokemonId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonDetailProvider>(
      builder: (context, provider, child) {
        return switch (provider.remoteState) {
          RemoteStateLoading() => Center(child: CircularProgressIndicator()),
          RemoteStateError(error: var error) => Center(child: Text(error)),
          RemoteStateSuccess(data: var data) => PokemonDetailContent(
            detail: data,
          ),
          _ => Center(child: CircularProgressIndicator()),
        };
      },
    );
  }
}
