import 'package:flutter/material.dart';

class FightResult {
  final String result;
  final Color color;

  const FightResult._(this.result, this.color);

  static const won = FightResult._("won", Colors.green);
  static const draw = FightResult._("draw", Colors.blue);
  static const lost = FightResult._("lost", Colors.red);

  @override
  String toString() {
    return 'FightResult{result: $result, color: $color}';
  }

  static FightResult? calculateResult(int yourLives, int enemysLives) {
    if (yourLives == 0 && enemysLives == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLives == 0) {
      return won;
    }
    return null;
  }

  static valueOf(String? data) {
    if (data == won.result) {
      return won;
    } else if (data == draw.result) {
      return draw;
    } else if (data == lost.result) {
      return lost;
    }
    return null;
  }
}
