import 'dart:math';
import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../squid-game.dart';
import '../view.dart';

class Yh {
  final SquidGame game;
  late Rect rect;
  late List<Sprite> sprites;
  AudioPlayer audio = AudioPlayer();
  double term = 0;
  double times = 0;
  double songTime = 5;

  var rng = new Random();

  late TextComponent _scoreText;

  Yh(this.game) {
    _setStartedRect();
    _setSprite();
  }

  reset() async {
    mute();

    times = 0;
    songTime = -1;
  }

  mute() {
    audio.pause();
    audio.stop();
  }

  random(min, max) {
    return min + rng.nextInt(max - min);
  }

  doSong() async {
    songTime = 5;
    times = random(8, 12) * 1.0;
    term = times;
    if (game.activeView == View.playing) {
      game.loadSound('song.mp3', 0.9);
    }
  }

  void doWatch() async {
    audio.pause();
    audio.stop();
  }

  void render(Canvas c) {
    int status = isSong() ? 1 : 0;
    sprites[status].renderRect(c, rect);

    _message(c);
  }

  _message(Canvas c) {
    if (!game.isReadyCompleted()) return;

    const size = 1.5;
    String text = isSong() ? "무궁화 꽃이 피었습니다" : ".....";
    Color color = isSong() ? Colors.red : Colors.green;

    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold),
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

  bool isSong() {
    return songTime >= 0;
  }

  void update(double t) {
    times = times - t;
    songTime = songTime - t;

    if (songTime < 0) {
      this.doWatch();
    }

    if (times < 0) {
      this.doSong();
    }
  }

  _setStartedRect() {
    double x = (game.screenSize.width - game.tileSize * 2) / 2;
    this.rect = Rect.fromLTWH(x, 30, game.tileSize * 2, game.tileSize * 2);
  }

  _setSprite() {
    sprites = [];
    sprites.add(Sprite('yf.png'));
    sprites.add(Sprite('yb.png'));
  }
}
