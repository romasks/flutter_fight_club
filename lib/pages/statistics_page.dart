import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
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
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return SizedBox();
                }
                final SharedPreferences prefs = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: FightResult.values.map((item) {
                    int value = prefs.getInt("stats_${item.result}") ?? 0;
                    String key =
                        item.result[0].toUpperCase() + item.result.substring(1);
                    return SizedBox(
                      height: 40,
                      child: Text(
                        "$key: $value",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    );
                  }).toList(),
                );
              },
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
