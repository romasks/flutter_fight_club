import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

class FightPage extends StatefulWidget {
  FightPage({Key? key}) : super(key: key);

  @override
  _FightPageState createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  static const int maxLives = 5;

  BodyPart? attackingBodyPart;
  BodyPart? defendingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String turnResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemyLivesCount: enemysLives,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: ColoredBox(
                  color: FightClubColors.darkViolet,
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        turnResult,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: FightClubColors.darkGreyText),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            ActionButton(
              text: _isEndGame() ? "Start new game" : "Go",
              onTap: _onGoButtonClick,
              color: _getGoButtonColor(),
            ),
            SizedBox(height: 16)
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
        turnResult = "Start new game";
        yourLives = maxLives;
        enemysLives = maxLives;
      });
    } else if (_isChoiceMade()) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives -= 1;
        }
        if (youLoseLife) {
          yourLives -= 1;
        }

        turnResult = _setTurnResultInfo();

        whatEnemyAttacks = BodyPart.random();
        whatEnemyDefends = BodyPart.random();

        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  String _setTurnResultInfo() {
    if (yourLives == 0 && enemysLives == 0) {
      return "Draw";
    } else if (yourLives == 0) {
      return "You lost";
    } else if (enemysLives == 0) {
      return "You won";
    } else {
      String firstLine = attackingBodyPart == whatEnemyDefends
          ? "Your attack was blocked."
          : "You hit enemy's ${attackingBodyPart!.name.toLowerCase()}.";
      String secondLine = whatEnemyAttacks == defendingBodyPart
          ? "Enemy's attack was blocked."
          : "Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}.";
      return "$firstLine\n$secondLine";
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
    return yourLives == 0 || enemysLives == 0;
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
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ColoredBox(color: Colors.white)),
              Expanded(child: ColoredBox(color: FightClubColors.darkViolet)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 27, horizontal: 25),
                      child: LivesWidget(
                        overallLivesCount: maxLivesCount,
                        currentLivesCount: yourLivesCount,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 12),
                          child: Text(
                            "You",
                            style:
                                TextStyle(color: FightClubColors.darkGreyText),
                          ),
                        ),
                        Image.asset(
                          FightClubImages.youAvatar,
                          height: 92,
                          width: 92,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: ColoredBox(color: Colors.green),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 12),
                          child: Text(
                            "Enemy",
                            style:
                                TextStyle(color: FightClubColors.darkGreyText)
                          ),
                        ),
                        Image.asset(
                          FightClubImages.enemyAvatar,
                          height: 92,
                          width: 92,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      child: LivesWidget(
                        overallLivesCount: maxLivesCount,
                        currentLivesCount: enemyLivesCount,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
    return Column(
      children: List.generate(overallLivesCount, (index) {
        String hearthPath;
        if (index < currentLivesCount) {
          hearthPath = FightClubIcons.heartFull;
        } else {
          hearthPath = FightClubIcons.heartEmpty;
        }
        return Padding(
          padding:
              EdgeInsets.only(bottom: index == overallLivesCount - 1 ? 0 : 4),
          child: Image.asset(
            hearthPath,
            width: 18,
            height: 18,
          ),
        );
      }),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;

  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
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
              Text("Attack".toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
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
              Text("Defend".toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
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
                      color: selected
                          ? FightClubColors.whiteText
                          : FightClubColors.darkGreyText,
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
