// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  Pokemon({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String name;
  String url;

  Result({required this.name, required this.url});

  factory Result.fromJson(Map<String, dynamic> json) =>
      Result(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};

  String nameCapitalized() {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }

  int id() {
    return int.parse(url.split('/')[url.split('/').length - 2]);
  }
}

// Sample Pokemon data matching the design
final List<Result> pokemonData = [
  Result(
    name: 'Bulbasaur',
    url:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  ),
  Result(
    name: 'Mewtwo',
    url:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
  ),
];
