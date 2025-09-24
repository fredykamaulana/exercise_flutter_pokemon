import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon_detail.dart';
import 'package:pokemon/screens/pokemon_detail/widgets/pokemon_detail_stat.dart';

class PokemonDetailContent extends StatelessWidget {
  final PokemonDetail detail;
  const PokemonDetailContent({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: detail.color(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: detail.color(),
          height: 800,
          child: Stack(
            children: [
              // Background Pokeball circle
              Positioned(
                right: -60,
                top: 120,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),

              Column(
                children: [
                  const SizedBox(height: 20),

                  //Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.nameCapitalized(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                detail.typeCapitalized(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '#${detail.id.toString().padLeft(3, '0')}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 200),

                  // Bottom information Section
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            const Text(
                              "Base Stats",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            PokemonDetailStat(label: "HP", value: detail.hp),
                            PokemonDetailStat(
                              label: "Attack",
                              value: detail.attack,
                            ),
                            PokemonDetailStat(
                              label: "Defense",
                              value: detail.defense,
                            ),
                            PokemonDetailStat(
                              label: "Speed",
                              value: detail.speed,
                            ),
                            const SizedBox(height: 10),
                            Text('Height: ${detail.height} CM'),
                            const SizedBox(height: 5),
                            Text('Weight: ${detail.weight} KG'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 160,
                left: 0,
                right: 0,
                child: Center(
                  child: Hero(
                    tag: detail.id,
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${detail.id}.png',
                      height: 180,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
