import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  final TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: FightClubColors.darkGreyText,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                "Statistics".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            /*Column(
              children: [
                Text("Won: 22", textAlign: TextAlign.center, style: textStyle),
                Text("Draw: 5", textAlign: TextAlign.center, style: textStyle),
                Text("Lost: 15", textAlign: TextAlign.center, style: textStyle),
              ],
            ),
            Expanded(child: SizedBox()),*/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SecondaryActionButton(
                text: "Back",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
