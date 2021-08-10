import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;
  final Color color;

  const FightResult._(this.result, this.color);

  static const won = FightResult._("won", FightClubColors.wonFightResult);
  static const draw = FightResult._("draw", FightClubColors.drawFightResult);
  static const lost = FightResult._("lost", FightClubColors.lostFightResult);
  
  static const values = [won, draw, lost];

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
    return values.firstWhere((item) => item.result == data!);
  }
}
