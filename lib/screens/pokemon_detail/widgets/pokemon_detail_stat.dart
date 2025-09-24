import 'package:flutter/material.dart';

class PokemonDetailStat extends StatelessWidget {
  final String label;
  final int value;

  const PokemonDetailStat({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          SizedBox(width: 30, child: Text("$value")),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.red.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(
                value > 50 ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
