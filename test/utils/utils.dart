import 'package:pokemon/data/model/pokemon.dart';
import 'package:pokemon/data/model/pokemon_detail.dart';

List<Result> dummyPokemonList = [
  Result(name: 'bulbasaur', url: ''),
  Result(name: 'ivysaur', url: ''),
  Result(name: 'pikachu', url: ''),
  Result(name: 'raichu', url: ''),
  Result(name: 'charmander', url: ''),
];

Pokemon dummyPokemon({List<Result> pokemonList = const []}) =>
    Pokemon(count: 1000, next: '', previous: '', results: pokemonList);

PokemonDetail dummyPokemonDetail = PokemonDetail(
  height: 20,
  id: 1,
  name: 'bulbasaur',
  order: 1,
  species: Species(name: 'grass', url: 'url'),
  stats: [
    Stat(
      baseStat: 10,
      effort: 10,
      stat: Species(name: 'name', url: 'url'),
    ),
  ],
  types: [
    Type(
      slot: 10,
      type: Species(name: 'name', url: 'url'),
    ),
  ],
  weight: 80,
);
