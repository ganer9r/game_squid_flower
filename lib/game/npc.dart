import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../squid-game.dart';

class Npc {
  final SquidGame game;
  final x;
  late Rect playerRect;
  late Sprite sprite;

  Npc(this.game, this.x) {
    _setStartedRect();
    _setPlayer();
  }

  void render(Canvas c) {
    sprite.renderRect(c, playerRect);
  }

  void update(double t) {}

  _setStartedRect() {
    double y = 80;
    this.playerRect =
        Rect.fromLTWH(x - (game.tileSize / 2), y, game.tileSize, game.tileSize);
  }

  _setPlayer() {
    sprite = Sprite('npc.png');
  }
}
