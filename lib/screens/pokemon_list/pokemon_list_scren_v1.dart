import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/model/post_response.dart';
import 'package:pokemon/data/service/pokemon_service.dart';
import 'package:pokemon/data/service/upload_image_service.dart';
import 'package:pokemon/data/state/remote_state.dart';
import 'package:pokemon/screens/pokemon_list/pokemon_card.dart';

class PokemonListScreenV1 extends StatefulWidget {
  const PokemonListScreenV1({super.key});

  @override
  State<PokemonListScreenV1> createState() => _PokemonListScreenV1State();
}

class _PokemonListScreenV1State extends State<PokemonListScreenV1> {
  final PokemonService service = PokemonService();
  final UploadImageService postService = UploadImageService();

  @override
  Widget build(BuildContext context) {
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

      body: FutureBuilder<PostResponse>(
        future: postService.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: snapshot.data!.data.posts.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data!.data.posts[index];
                  return PostCard(post: post);
                },
              ),
            );
          } else {
            return Center(child: Text('No data to show'));
          }
        },
      ),

      // body: FutureBuilder<RemoteState>(
      //   future: service.fetchPokemonList(),
      //   builder: (context, snapshot) {
      //     if (snapshot.data != null && snapshot.hasData) {
      //       return switch (snapshot.data!) {
      //         RemoteStateLoading() => Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //         RemoteStateSuccess<Pokemon>(data: var data) => Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           child: GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               crossAxisSpacing: 16,
      //               mainAxisSpacing: 16,
      //             ),
      //             itemCount: data.results.length,
      //             itemBuilder: (context, index) {
      //               final pokemon = data.results[index];
      //               return PokemonCard(pokemon: pokemon);
      //             },
      //           ),
      //         ),
      //         RemoteStateError(error: var message) => Center(
      //           child: Text(message),
      //         ),
      //         _ => SizedBox.shrink(),
      //       };
      //     } else {
      //       return Center(child: Text('No data to show'));
      //     }
      //   },
      // ),
    );
  }
}
