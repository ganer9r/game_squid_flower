import 'dart:ui';

import 'package:flutter/material.dart';

import '../view.dart';
import 'btn-home.dart';
import 'btn-question.dart';
import '../squid-game.dart';
import 'btn-refresh.dart';

class Status {
  final SquidGame game;

  late TextPainter painter;
  late TextStyle textStyle;
  late Offset position;

  late HomeButton homeButton;
  late RefreshButton refreshButton;
  late QuestionButton questionButton;

  Status(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;

    _addButtons();
  }

  void render(Canvas c) {
    if (game.activeView == View.playing) {
      painter.paint(c, position);

      // homeButton.render(c);
      // refreshButton.render(c);
      // questionButton.render(c);
    }
  }

  void update(double t) {
    int time = game.playTime.ceil();
    painter.text = TextSpan(
      text: "Time : " + time.toString(),
      style: textStyle,
    );

    painter.layout();
    position = Offset(20, 15);
  }

  onTapDown(TapDownDetails d) {
    return;
    if (game.activeView != View.playing) return;

    if (homeButton.rect.contains(d.globalPosition)) {
      homeButton.onTapDown();
    }

    if (refreshButton.rect.contains(d.globalPosition)) {
      refreshButton.onTapDown();
    }

    if (questionButton.rect.contains(d.globalPosition)) {
      questionButton.onTapDown();
    }
  }

  _addButtons() {
    homeButton = HomeButton(this.game);
    refreshButton = RefreshButton(this.game);
    questionButton = QuestionButton(this.game);
  }
}
