import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

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
                color: FightClubColors.blackButton,
              ),
            ),
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
