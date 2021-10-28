import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../squid-game.dart';

class Backyard {
  final SquidGame game;
  double field = 500;
  late Sprite bgSprite;
  late Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('bg.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
    _end(c);
    _start(c);
  }

  safeHeight() {
    return (game.screenSize.height - field) / 2;
  }

  _image() {}

  _end(Canvas c) {
    Rect bgRect = Rect.fromLTWH(0, safeHeight(), game.screenSize.width, 2);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.green;
    c.drawRect(bgRect, bgPaint);
  }

  _field(Canvas c) {
    Rect bgRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.brown;
    c.drawRect(bgRect, bgPaint);
  }

  _start(Canvas c) {
    Rect bgRect =
        Rect.fromLTWH(0, field + safeHeight(), game.screenSize.width, 2);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.red;
    c.drawRect(bgRect, bgPaint);
  }

  void update(double t) {}
}
