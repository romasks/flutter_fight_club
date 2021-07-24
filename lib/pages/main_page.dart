import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FightResult fightResult = FightResult.won;

    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            Text(
              "The\nFight\nClub".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: FightClubColors.blackButton,
              ),
            ),
            Expanded(child: SizedBox()),
            FightResultWidget(fightResult: fightResult),
            Expanded(child: SizedBox()),
            ActionButton(
              text: "Start",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FightPage(),
                  ),
                );
              },
              color: FightClubColors.blackButton,
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}

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
}
