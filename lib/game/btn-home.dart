import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:squid_flower/squid-game.dart';

import '../view.dart';

class HomeButton {
  final SquidGame game;
  late Rect rect;
  late Sprite sprite;

  HomeButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 2),
      20,
      game.tileSize / 1.5,
      game.tileSize / 1.5,
    );

    sprite = Sprite('ui/home.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.setHome();
  }
}
