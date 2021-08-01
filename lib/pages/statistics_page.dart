import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  final TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: FightClubColors.darkGreyText,
  );

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                "Statistics",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Column(
              children: [
                FutureBuilder<int?>(
                  future: _prefs.then((prefs) => prefs.getInt("stats_won")),
                  builder: (context, snapshot) {
                    int counterWons = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      counterWons = snapshot.data!;
                    }
                    return SizedBox(
                      height: 40,
                      child: Text(
                        "Won: $counterWons",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    );
                  },
                ),
                FutureBuilder<int?>(
                  future: _prefs.then((prefs) => prefs.getInt("stats_draw")),
                  builder: (context, snapshot) {
                    int counterDraws = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      counterDraws = snapshot.data!;
                    }
                    return SizedBox(
                      height: 40,
                      child: Text(
                        "Draw: $counterDraws",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    );
                  },
                ),
                FutureBuilder<int?>(
                  future: _prefs.then((prefs) => prefs.getInt("stats_lost")),
                  builder: (context, snapshot) {
                    int counterLosts = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      counterLosts = snapshot.data!;
                    }
                    return SizedBox(
                      height: 40,
                      child: Text(
                        "Lost: $counterLosts",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(child: SizedBox()),
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
