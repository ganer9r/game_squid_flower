import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:squid_flower/utils/storages.dart';

import '../squid-game.dart';
import '../view.dart';

class HomeView {
  final SquidGame game;

  late Rect playRect;
  late Sprite playSprite;

  HomeView(this.game) {
    _buildButton();
  }

  void render(Canvas c) {
    _background(c);

    _title(c);
    playSprite.renderRect(c, playRect);
  }

  void update(double t) {}

  _buildButton() {
    playRect = Rect.fromLTWH(
      (game.screenSize.width - 150) / 2,
      500,
      150,
      50,
    );

    playSprite = Sprite('play.png');
  }

  _background(Canvas c) {
    Rect bgRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.black54;
    c.drawRect(bgRect, bgPaint);
  }

  _dialog(Canvas c) {
    double x = (game.screenSize.width - 200) / 2;
    double y = (game.screenSize.height - 200) / 2;
    Rect bgRect = Rect.fromLTWH(x, y, 200, 200);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.white;
    c.drawRect(bgRect, bgPaint);
  }

  _title(Canvas c) {
    final textSpan = const TextSpan(
      text: '무궁화 꽃이\n피었습니다',
      style: const TextStyle(
          color: Colors.black,
          fontFamily: "Kty",
          fontSize: 30,
          shadows: [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.white),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.white),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.white),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.white),
          ]
          // ..color = Colors.amber,
          ),
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
    final offset = Offset(x, 100);
    textPainter.paint(c, offset);
  }

  onTapDown(TapDownDetails d) {
    if (game.activeView != View.home) return;

    // GamesServices.showLeaderboards(
    //     androidLeaderboardID: Storages.aosLeaderboardID);

    if (playRect.contains(d.globalPosition)) {
      game.start();
    }
  }
}
