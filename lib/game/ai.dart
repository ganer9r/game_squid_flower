import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

import '../squid-game.dart';
import '../view.dart';

class Ai {
  final SquidGame game;
  final int index;
  late Rect playerRect;
  late Paint playerPaint;
  late SpriteSheet spritesheet;

  late double safedY;
  late double speed;
  late double _timer;
  late double _regen;

  bool isDeath = false;
  int char = 0;
  int step = 1;

  Ai(this.game, this.index) {
    _setStartedRect();
    _setPlayer();

    regen();
    resetSpeed();
    safedY = game.background.safeHeight() - game.tileSize;
  }

  void render(Canvas c) {
    if (isDeath) {
      spritesheet.getSprite(char, 3).renderRect(c, playerRect);
      return;
    }

    int mod = step % 4;
    spritesheet.getSprite(char, mod == 3 ? 1 : mod).renderRect(c, playerRect);
  }

  regen() {
    _regen = 4;
    speed = random(10, 25) * 0.01;
  }

  resetSpeed() {
    _timer = speed;
  }

  _checkDeath() {
    if (game.playTime > 118) return false;
    if (game.yh.songTime >= 0) return false; //노래 중이면 안죽음
    double rand = random(0, 600);

    // 빨리 가고 있는데 노래가 끝남.
    if (speed > 0.23 &&
        game.yh.term - game.yh.songTime - 0.2 > game.yh.times &&
        rand > 450) {
      _setPlayerDeath();
      return true;
    }

    if (game.yh.times > 3) return false;
    if (speed < 0.21) return false;
    if (rand == 0) {
      _setPlayerDeath();
      return true;
    }

    return false;
  }

  _isSafed() {
    return this.playerRect.top <= safedY;
  }

  void update(double t) {
    if (isDeath) return;
    if (game.activeView != View.playing) return;

    if (_isSafed()) return;
    if (_checkDeath()) return;
    if (!game.yh.isSong()) return;

    _timer -= t;
    _regen -= t;
    if (_timer > 0) return;

    double y = this.playerRect.top - 2;
    double x = this.playerRect.left;
    step++;

    this.playerRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

    resetSpeed();
    if (_regen < 0) {
      regen();
    }
  }

  random(min, max) {
    var rng = new Random();
    return (min + rng.nextInt(max.toInt() - min.toInt())).toDouble();
  }

  _getx() {
    int xposition = (index / 3).toInt();
    xposition = xposition > 3 ? xposition + 1 : xposition;
    int half = (game.tileSize / 2).toInt();

    return xposition * game.tileSize + random(-half, half);
  }

  _setStartedRect() {
    double x = _getx();
    double yy = random(-20, game.tileSize);
    double y = (500 + (game.screenSize.height - 500) / 2) + yy;

    this.playerRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }

  _setPlayer() {
    playerPaint = Paint();
    playerPaint.color = Colors.yellow;

    isDeath = false;
    char = random(0, 5).toInt();
    String img = random(0, 2).toInt() == 1 ? 'sprite_m.png' : 'sprite_w.png';

    spritesheet = SpriteSheet(
      imageName: img,
      textureWidth: 45,
      textureHeight: 45,
      columns: 4,
      rows: 5,
    );
  }

  _setPlayerDeath() {
    isDeath = true;
    game.loadSound('gun.wav', 0.4);
  }
}
