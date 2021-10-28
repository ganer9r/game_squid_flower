import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../utils/storages.dart';
import '../squid-game.dart';
import '../view.dart';

class ResultView {
  final SquidGame game;
  int status = 0;

  late Rect playRect;
  late Sprite playSprite;
  late Rect failRect;
  late Sprite failSprite;

  ResultView(this.game) {
    _buildButton();
    _buildFail();
  }

  void render(Canvas c) {
    _background(c);
    _box(c);

    _title(c);
    _result(c);
    _sec(c);

    playSprite.renderRect(c, playRect);
    if (status == 0) {
      failSprite.renderRect(c, failRect);
    }
  }

  setStatus(status) {
    this.status = status;
    game.activeView = View.result;
    int sec = (game.gameTime - game.playTime).ceil();

    if (status == 0) {
      game.loadSound('gun.wav', 0.8);
      Storages.failed(sec);
    } else {
      int best = Storages.success(sec);
      this.game.bestTime = best;
    }
  }

  void update(double t) {}

  onTapDown(TapDownDetails d) {
    if (game.activeView != View.result) return;

    if (playRect.contains(d.globalPosition)) {
      game.start();
    }
  }

  _box(Canvas c) {
    final x = (game.screenSize.width - 250) / 2;
    Rect bgRect = Rect.fromLTWH(x, 150, 250, 250);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.white;
    c.drawRect(bgRect, bgPaint);
  }

  _buildButton() {
    playRect = Rect.fromLTWH(
      (game.screenSize.width - 150) / 2,
      500,
      150,
      50,
    );

    playSprite = Sprite('play.png');
  }

  _buildFail() {
    failRect = Rect.fromLTWH(
      (game.screenSize.width - 200) / 2,
      220,
      200,
      130,
    );

    failSprite = Sprite('fail2.png');
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
    String text = status == 1 ? "Success" : "Failed";
    Color color = status == 1 ? Colors.green : Colors.red;
    const bg = Colors.black;
    const size = 1.5;

    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontFamily: "Kty", fontSize: 36, shadows: [
        Shadow(
            // bottomLeft
            offset: Offset(-size, -size),
            color: bg),
        Shadow(
            // bottomRight
            offset: Offset(size, -size),
            color: bg),
        Shadow(
            // topRight
            offset: Offset(size, size),
            color: bg),
        Shadow(
            // topLeft
            offset: Offset(-size, size),
            color: bg),
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
    final offset = Offset(x, 160);
    textPainter.paint(c, offset);
  }

  _sec(Canvas c) {
    if (status == 0) return;

    const bg = Colors.black;
    const size = 1.5;

    final textSpan = TextSpan(
      text: 'sec',
      style: TextStyle(color: Colors.grey, fontSize: 24),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 100,
      maxWidth: 100,
    );

    double x = (game.screenSize.width + 30) / 2;
    final offset = Offset(x, 265);
    textPainter.paint(c, offset);
  }

  _result(Canvas c) {
    if (status == 0) return;

    const bg = Colors.black;
    const size = 1.5;
    int sec = (game.gameTime - game.playTime).ceil();

    final textSpan = TextSpan(
      text: sec.toString(),
      style: TextStyle(color: Colors.black, fontFamily: "Kty", fontSize: 36),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 100,
      maxWidth: 100,
    );

    double x = (game.screenSize.width - 200) / 2;
    final offset = Offset(x, 250);
    textPainter.paint(c, offset);
  }
}
