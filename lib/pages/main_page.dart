import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "The\nFight\nClub".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: FightClubColors.blackButton,
              ),
            ),
            SizedBox.expand(),
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
            )
          ],
        ),
      ),
    );
  }
}
