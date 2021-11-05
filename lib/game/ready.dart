import 'dart:ui';

import 'package:flutter/material.dart';

import '../view.dart';
import 'btn-home.dart';
import 'btn-question.dart';
import '../squid-game.dart';
import 'btn-refresh.dart';

class Ready {
  final SquidGame game;

  late TextStyle textStyle;
  late Offset position;

  Ready(this.game) {
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

    position = Offset(100, 100);
  }

  void render(Canvas c) {
    if (game.activeView != View.playing) return;
    if (game.isReadyCompleted()) return;

    const bg = Colors.black;
    const size = 1.5;

    final textSpan = TextSpan(
      text: game.readyTime.ceil().toString(),
      style: TextStyle(color: Colors.black, fontFamily: "Kty", fontSize: 20),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 200,
      maxWidth: 200,
    );

    double x = (game.screenSize.width - 200) / 2;
    final offset = Offset(x, 160);
    textPainter.paint(c, offset);

    _renderMessage(c);
  }

  _renderMessage(Canvas c) {
    final textSpan = TextSpan(
      text: "Tap to move forward",
      style: TextStyle(color: Colors.black, fontFamily: "Kty", fontSize: 20),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 200,
      maxWidth: 200,
    );

    double x = (game.screenSize.width - 200) / 2;
    final offset = Offset(x, 500);
    textPainter.paint(c, offset);
  }

  void update(double t) {}
}
