import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:squid_flower/squid-game.dart';

class RefreshButton {
  final SquidGame game;
  late Rect rect;
  late Sprite sprite;

  RefreshButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 3),
      20,
      game.tileSize / 1.5,
      game.tileSize / 1.5,
    );
    sprite = Sprite('ui/refresh.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.start();
    // game.activeView = View.credits;
  }
}
