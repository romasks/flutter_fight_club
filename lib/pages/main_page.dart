import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                color: FightClubColors.darkGreyText,
              ),
            ),
            Expanded(child: SizedBox()),
            FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                (prefs) => prefs.getString("last_fight_result"),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: [
                      Text(
                        "Last fight result",
                        style: TextStyle(
                          fontSize: 14,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                      SizedBox(height: 12),
                      FightResultWidget(
                        fightResult: FightResult.valueOf(snapshot.data!),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            Expanded(child: SizedBox()),
            SecondaryActionButton(
              text: "Statistics",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StatisticsPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
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
