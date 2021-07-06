import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int maxLives = 5;

  BodyPart? attackingBodyPart;
  BodyPart? defendingBodyPart;

  int yourLives = maxLives;
  int enemyLives = maxLives;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 222, 240, 1),
      body: Column(
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
            onTap: _onGoButtonClick,
            color: attackingBodyPart == null || defendingBodyPart == null
                ? Colors.black38
                : Color.fromRGBO(0, 0, 0, 0.87),
          ),
          SizedBox(height: 40)
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _selectAttackingBodyPart(BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _selectDefendingBodyPart(BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _onGoButtonClick() {
    if (attackingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
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
              overallLivesCount: 5,
              currentLivesCount: 1,
            ),
            SizedBox(width: 12),
            LivesWidget(
              overallLivesCount: 5,
              currentLivesCount: 3,
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
            return Text("1");
          } else {
            return Text("0");
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
                    ? Color.fromRGBO(28, 121, 206, 1)
                    : FightClubColors.darkGreyText,
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
  final VoidCallback onTap;
  final Color color;

  const GoButton({Key? key, required this.onTap, required this.color})
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
                    "Go".toUpperCase(),
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
