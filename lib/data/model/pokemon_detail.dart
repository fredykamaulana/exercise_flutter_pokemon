// To parse this JSON data, do
//
//     final pokemonDetail = pokemonDetailFromJson(jsonString);

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

String pokemonDetailToJson(PokemonDetail data) => json.encode(data.toJson());

final Map<String, Color> typeColors = {
  "Grass": Colors.green.shade600,
  "Poison": Colors.purple.shade600,
  "Fire": Colors.red.shade600,
  "Flying": Colors.indigo.shade200,
  "Water": Colors.blue.shade600,
  "Bug": Colors.green.shade300,
  "Normal": Colors.grey.shade600,
  "Electric": Colors.yellow.shade600,
  "Ground": Colors.brown.shade600,
  "Fairy": Colors.pink.shade300,
  "Fighting": Colors.orange.shade600,
  "Psychic": Colors.pink.shade600,
  "Rock": Colors.grey.shade800,
  "Steel": Colors.blueGrey.shade600,
  "Ice": Colors.cyan.shade200,
  "Ghost": Colors.indigo.shade600,
  "Dragon": Colors.teal.shade800,
  "Dark": Colors.grey.shade900,
  "Unknown": Colors.white,
  "Stellar": Colors.amber.shade600,
};

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

  static const maxHp = 300;
  static const maxAttack = 200;
  static const maxDefense = 200;
  static const maxSpeed = 200;
  static const maxExp = 10000;

  final random = Random();
  int get exp => random.nextInt(maxExp);

  int get hp => stats.firstWhere((stat) => stat.stat.name == 'hp').baseStat;
  int get attack =>
      stats.firstWhere((stat) => stat.stat.name == 'attack').baseStat;
  int get defense =>
      stats.firstWhere((stat) => stat.stat.name == 'defense').baseStat;
  int get speed =>
      stats.firstWhere((stat) => stat.stat.name == 'speed').baseStat;

  String getHeightString() => '${(height / 10).toStringAsFixed(1)} M';
  String getWeightString() => '${(weight / 10).toStringAsFixed(1)} kG';

  String getHpString() => "$hp/$maxHp";
  String getAttackString() => "$attack/$maxAttack";
  String getDefenseString() => "$defense/$maxDefense";
  String getSpeedString() => "$speed/$maxSpeed";
  String getExpString() => "$exp/$maxExp";

  String nameCapitalized() {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }

  String typeCapitalized() {
    final typeName = types.first.type.name;
    if (typeName.isEmpty) return '';
    return typeName[0].toUpperCase() + typeName.substring(1);
  }

  Color color() {
    final filteredMap = typeColors.entries
        .where((entry) => entry.key.toLowerCase() == types.first.type.name)
        .toList();
    return filteredMap.isNotEmpty
        ? filteredMap.first.value
        : Colors.grey.shade400;
  }
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
