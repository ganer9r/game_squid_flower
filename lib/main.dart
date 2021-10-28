import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

import 'squid-game.dart';
import 'package:games_services/games_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.initialize();

  Util flameUtil = Util();
  await flameUtil.fullScreen();

  await loadImages();

  try {
    GamesServices.signIn();
  } catch (e) {}

  SquidGame game = SquidGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

loadImages() async {
  await Flame.images.loadAll(<String>[
    'ui/home.png',
    'ui/question.png',
    'ui/ranking.png',
    'ui/refresh.png',
    'ui/trophy.png',
    //
    'bg.png',
    'fail.png',
    'npc.png',
    'play.png',
    'player.png',
    'yf.png',
    'yb.png',

    'sprite_p.png',
    'sprite_m.png',
    'sprite_w.png',
  ]);

  await Flame.audio.loadAll(<String>[
    'gun.wav',
    'song.mp3',
    'bg.mp3',
  ]);
}
