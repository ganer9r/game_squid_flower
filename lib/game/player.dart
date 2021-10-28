import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

import '../squid-game.dart';
import '../view.dart';

class Player {
  final SquidGame game;
  late Size screenSize;
  late Rect playerRect;
  late Paint playerPaint;
  late double safedY;
  late SpriteSheet spritesheet;
  int step = 1;

  Player(this.game, this.screenSize) {
    _setStartedRect();
    _setPlayer();

    safedY = game.background.safeHeight() - game.tileSize;
  }

  void render(Canvas c) {
    // c.drawRect(playerRect, playerPaint);
    int mod = step % 4;
    spritesheet.getSprite(0, mod == 3 ? 1 : mod).renderRect(c, playerRect);
  }

  void update(double t) {}

  _setStartedRect() {
    double x = (screenSize.width - game.tileSize) / 2;
    double y = 500 + (screenSize.height - 500) / 2;

    this.playerRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    step = 1;
  }

  _setPlayer() {
    playerPaint = Paint();
    playerPaint.color = Colors.yellow;

    spritesheet = SpriteSheet(
      imageName: 'sprite_p.png',
      textureWidth: 45,
      textureHeight: 45,
      columns: 4,
      rows: 1,
    );
  }

  move() {
    if (!game.isReadyCompleted()) return;
    // if (game.activeView != View.playing) return;
    if (!game.yh.isSong()) {
      game.setResult(0);
    }

    double y = this.playerRect.top - 2;
    double x = this.playerRect.left;
    step++;

    this.playerRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

    if (safedY > y) {
      game.setResult(1);
    }
  }
}
