import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/network/http_api_client.dart';

class PokemonCard extends StatelessWidget {
  final Result pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: pokemon.id());
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background pattern circles
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -10,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.nameCapitalized(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '#${pokemon.id().toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        provideImageUrl(pokemon.id()),
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withValues(alpha: 0.8),
                                ),
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.catching_pokemon,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Pokemon image placeholder
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: Container(
                  //     width: 60,
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withValues(alpha: 0.1),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Icon(
                  //       Icons.catching_pokemon,
                  //       color: Colors.white.withValues(alpha: 0.1),
                  //       size: 40,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // ID number in top right
            // Positioned(
            //   top: 8,
            //   right: 12,
            //   child: Text(
            //     '#001',
            //     style: TextStyle(
            //       color: Colors.black.withValues(alpha: 0.5),
            //       fontSize: 12,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
