import 'package:flutter/material.dart';
import 'package:pokemon/data/model/pokemon_detail.dart';
import 'package:pokemon/data/network/http_api_client.dart';

class PokemonDetailScreenV1 extends StatefulWidget {
  final int pokemonId;

  const PokemonDetailScreenV1({super.key, required this.pokemonId});

  @override
  _PokemonDetailScreenV1State createState() => _PokemonDetailScreenV1State();
}

class _PokemonDetailScreenV1State extends State<PokemonDetailScreenV1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with Pokemon image
          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.cyan],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                // Background pattern circles
                Positioned(
                  right: -50,
                  top: 50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 200,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                // App bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                // Pokemon info
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "widget.pokemon.name",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "widget.pokemon.type",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              //'#${widget.pokemon.id.toString().padLeft(3, '0')}',
                              '#001',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Pokemon image
                Positioned(
                  right: 20,
                  bottom: -20,
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Image.network(
                      provideImageUrl(1),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.catching_pokemon,
                          size: 120,
                          color: Colors.white.withValues(alpha: 0.8),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom content with tabs
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Tabs
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.amber,
                      indicatorWeight: 3,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Base Stats'),
                        Tab(text: 'Evolution'),
                        Tab(text: 'Moves'),
                      ],
                    ),
                  ),
                  // Tab content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildAboutTab(),
                        _buildBaseStatsTab(),
                        _buildEvolutionTab(),
                        _buildMovesTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Charmander is a Fire type Pokémon. It has a flame at the tip of its tail, which indicates its emotions.',
            style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBaseStatsTab() {
    final stats = [
      StatData('HP', 39, Colors.red),
      StatData('Attack', 52, Colors.orange),
      StatData('Defense', 43, Colors.yellow),
      StatData('Sp. Atk', 60, Colors.blue),
      StatData('Sp. Def', 50, Colors.green),
      StatData('Speed', 65, Colors.pink),
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...stats.map((stat) => _buildStatRow(stat)).toList(),
          const SizedBox(height: 30),
          const Text(
            'Type defenses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'The effectiveness of each type on Charmander.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(StatData stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              stat.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              stat.value.toString(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: stat.value / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(stat.color),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvolutionTab() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evolution Chain',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Evolution information will be displayed here.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMovesTab() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Moves',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Move list will be displayed here.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
