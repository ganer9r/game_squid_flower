import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:squid_flower/squid-game.dart';

class QuestionButton {
  final SquidGame game;
  late Rect rect;
  late Sprite sprite;

  QuestionButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1),
      20,
      game.tileSize / 1.5,
      game.tileSize / 1.5,
    );

    sprite = Sprite('ui/question.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    print("QuestionButton click");
    // game.activeView = View.credits;
  }
}
