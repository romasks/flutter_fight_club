import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          textTheme: GoogleFonts.pressStart2pTextTheme(
        Theme.of(context).textTheme,
      )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const int maxLives = 5;

  BodyPart? attackingBodyPart;
  BodyPart? defendingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemyLives = maxLives;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemyLivesCount: enemyLives,
            ),
            Expanded(child: SizedBox()),
            ControlBattlePanel(
              defendingBodyPart: defendingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            GoButton(
              text: _isEndGame() ? "Start new game" : "Go",
              onTap: _onGoButtonClick,
              color: _getGoButtonColor(),
            ),
            SizedBox(height: 40)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _selectAttackingBodyPart(BodyPart value) {
    if (_isEndGame()) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _selectDefendingBodyPart(BodyPart value) {
    if (_isEndGame()) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _onGoButtonClick() {
    if (_isEndGame()) {
      setState(() {
        yourLives = maxLives;
        enemyLives = maxLives;
      });
    } else if (_isChoiceMade()) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemyLives -= 1;
        }
        if (youLoseLife) {
          yourLives -= 1;
        }

        whatEnemyAttacks = BodyPart.random();
        whatEnemyDefends = BodyPart.random();

        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  Color _getGoButtonColor() {
    if (_isEndGame()) {
      return FightClubColors.blackButton;
    } else if (!_isChoiceMade()) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  bool _isEndGame() {
    return yourLives == 0 || enemyLives == 0;
  }

  bool _isChoiceMade() {
    return attackingBodyPart != null && defendingBodyPart != null;
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo(
      {Key? key,
      required this.maxLivesCount,
      required this.yourLivesCount,
      required this.enemyLivesCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 16),
            Expanded(child: Center(child: Text("You"))),
            SizedBox(width: 12),
            Expanded(child: Center(child: Text("Enemy"))),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 11),
        Row(
          children: [
            SizedBox(width: 16),
            LivesWidget(
              overallLivesCount: maxLivesCount,
              currentLivesCount: yourLivesCount,
            ),
            SizedBox(width: 12),
            LivesWidget(
              overallLivesCount: maxLivesCount,
              currentLivesCount: enemyLivesCount,
            ),
            SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: List.generate(overallLivesCount, (index) {
          if (index < currentLivesCount) {
            return Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            );
          } else {
            return Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            );
          }
        }),
      ),
    );
  }
}

class ControlBattlePanel extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;

  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlBattlePanel({
    Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text("Attack".toUpperCase()),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: attackingBodyPart == BodyPart.head,
                  bodyPartSetter: selectAttackingBodyPart),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: attackingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectAttackingBodyPart),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: attackingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectAttackingBodyPart),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Text("Defend".toUpperCase()),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: defendingBodyPart == BodyPart.head,
                  bodyPartSetter: selectDefendingBodyPart),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectDefendingBodyPart),
              SizedBox(height: 16),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectDefendingBodyPart),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: ColoredBox(
                color: selected
                    ? FightClubColors.blueButton
                    : FightClubColors.greyButton,
                child: Center(
                  child: Text(
                    bodyPart.name.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton(
      {Key? key, required this.text, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 40,
              child: ColoredBox(
                color: color,
                child: Center(
                  child: Text(
                    text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: FightClubColors.whiteText),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
