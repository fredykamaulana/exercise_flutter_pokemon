// To parse this JSON data, do
//
//     final pokemonDetail = pokemonDetailFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

String pokemonDetailToJson(PokemonDetail data) => json.encode(data.toJson());

class PokemonDetail {
  int height;
  int id;
  String name;
  int order;
  Species species;
  List<Stat> stats;
  List<Type> types;
  int weight;

  PokemonDetail({
    required this.height,
    required this.id,
    required this.name,
    required this.order,
    required this.species,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
    height: json["height"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    species: Species.fromJson(json["species"]),
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "id": id,
    "name": name,
    "order": order,
    "species": species.toJson(),
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "weight": weight,
  };
}

class Species {
  String name;
  String url;

  Species({required this.name, required this.url});

  factory Species.fromJson(Map<String, dynamic> json) =>
      Species(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

class Stat {
  int baseStat;
  int effort;
  Species stat;

  Stat({required this.baseStat, required this.effort, required this.stat});

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Species.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}

class Type {
  int slot;
  Species type;

  Type({required this.slot, required this.type});

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(slot: json["slot"], type: Species.fromJson(json["type"]));

  Map<String, dynamic> toJson() => {"slot": slot, "type": type.toJson()};
}

class StatData {
  final String name;
  final int value;
  final Color color;

  StatData(this.name, this.value, this.color);
}
