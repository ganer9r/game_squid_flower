import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:squid_flower/utils/storages.dart';

import '../squid-game.dart';
import '../view.dart';

class ButtonView {
  final SquidGame game;

  late Rect rankRect;
  late Sprite rankSprite;

  late Rect trophyRect;
  late Sprite trophySprite;

  late Rect speakerRect;
  late Sprite speakerOnSprite;
  late Sprite speakerOffSprite;

  late Rect bestRect;
  late Sprite bestSprite;

  ButtonView(this.game) {
    _buildRank();
    _buildTrophy();
    _buildSpeaker();
    _buildBest();
  }

  void render(Canvas c) {
    if (game.activeView != View.home && game.activeView != View.result) return;

    rankSprite.renderRect(c, rankRect);
    trophySprite.renderRect(c, trophyRect);
    bestSprite.renderRect(c, bestRect);

    if (this.game.sound == 1) {
      speakerOnSprite.renderRect(c, speakerRect);
    } else {
      speakerOffSprite.renderRect(c, speakerRect);
    }

    _bestTime(c);
  }

  void update(double t) {}

  _bestTime(Canvas c) {
    final textSpan = TextSpan(
      text: this.game.bestTime.toString(),
      style: TextStyle(color: Colors.white, fontFamily: "Kty", fontSize: 20),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 100,
      maxWidth: 100,
    );

    double x = (game.screenSize.width - 100) / 2;
    final offset = Offset(x, 600);
    textPainter.paint(c, offset);
  }

  _buildRank() {
    rankRect = Rect.fromLTWH(
      20,
      20,
      50,
      50,
    );

    rankSprite = Sprite('ui/rank.png');
  }

  _buildTrophy() {
    trophyRect = Rect.fromLTWH(
      20,
      90,
      50,
      50,
    );

    trophySprite = Sprite('ui/trophy.png');
  }

  _buildSpeaker() {
    speakerRect = Rect.fromLTWH(
      game.screenSize.width - 70,
      20,
      50,
      50,
    );

    speakerOnSprite = Sprite('ui/speaker_on.png');
    speakerOffSprite = Sprite('ui/speaker_off.png');
  }

  _buildBest() {
    bestRect = Rect.fromLTWH(
      (game.screenSize.width - 140) / 2,
      570,
      140,
      65,
    );

    bestSprite = Sprite('ui/best.png');
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

  onTapDown(TapDownDetails d) async {
    if (game.activeView != View.home && game.activeView != View.result) return;

    if (rankRect.contains(d.globalPosition)) {
      GamesServices.showLeaderboards(
          androidLeaderboardID: Storages.aosLeaderboardID);
    }

    if (trophyRect.contains(d.globalPosition)) {
      GamesServices.showAchievements();
    }

    if (speakerRect.contains(d.globalPosition)) {
      int i = game.sound == 1 ? 0 : 1;
      game.sound = await Storages.sound(i);
      game.loadBgm();
    }
  }
}
