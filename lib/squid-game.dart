import 'dart:ui';
import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:squid_flower/game/npc.dart';
import 'package:squid_flower/game/status.dart';
import 'package:squid_flower/utils/storages.dart';

import 'game/ai.dart';
import 'game/backyard.dart';
import 'game/player.dart';
import 'game/ready.dart';
import 'game/yh.dart';
import 'utils/banners.dart';
import 'view.dart';
import 'views/button-view.dart';
import 'views/home-view.dart';
import 'views/result-view.dart';
import 'package:audioplayers/audioplayers.dart';

class SquidGame extends Game {
  late Size screenSize;
  late double tileSize;
  int sound = 1;

  late Player player;
  late Yh yh;
  late List<Npc> npcs;
  late List<Ai> ais;

  late Backyard background;
  late Status status;
  late Ready ready;
  late AudioPlayer homeBGM;

  bool isPaused = false;
  View activeView = View.home;
  late HomeView homeView;
  late ResultView resultView;
  late ButtonView buttonView;
  int bestTime = 120;

  double gameTime = 120;
  double playTime = 120;
  double readyTime = 5;

  late AdmobInterstitial interstitialAd;

  SquidGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    interstitialAd = AdmobInterstitial(adUnitId: Banners.interstitial());
    _loadBestTime();

    background = Backyard(this);
    status = Status(this);
    homeView = HomeView(this);
    resultView = ResultView(this);
    buttonView = ButtonView(this);
    ready = Ready(this);

    _setNpc();
    _setYounghee();
    _setPlayer();
    _setAis();

    _setBgm();
  }

  _setBgm() async {
    homeBGM = await Flame.audio.loopLongAudio('bg.mp3', volume: .5);
    homeBGM.stop();
    sound = await Storages.sound(-1);
    print("_setBgm");
    print(sound);

    loadBgm();
  }

  void lifecycleStateChange(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      isPaused = true;
      homeBGM.stop();
    } else {
      this.isPaused = false;
      loadBgm();
    }
  }

  loadBgm() async {
    if (this.activeView != View.home && this.activeView != View.result) return;

    if (sound == 1)
      homeBGM.resume();
    else
      homeBGM.stop();
  }

  loadSound(file, volume) async {
    if (sound == 1) Flame.audio.play(file, volume: volume);
  }

  _loadBestTime() async {
    bestTime = await Storages.getBestTime();
  }

  start() {
    _setPlayer();
    _setAis();
    yh.reset();
    loadAdmob();

    playTime = gameTime;
    readyTime = 5;
    activeView = View.playing;

    homeBGM.seek(Duration.zero);
    homeBGM.pause();
  }

  loadAdmob() {
    interstitialAd.load();
  }

  setHome() {
    yh.reset();
    activeView = View.home;
  }

  setResult(status) async {
    yh.mute();
    resultView.setStatus(status);

    interstitialAd.show();
    loadBgm();
  }

  void render(Canvas c) {
    if (isPaused) return;
    _background(c);

    yh.render(c);
    npcs.forEach((Npc fly) => fly.render(c));
    ais.forEach((Ai ai) => ai.render(c));

    player.render(c);
    status.render(c);
    ready.render(c);

    _screenRender(c);
  }

  void update(double t) {
    if (isPaused) return;
    if (activeView == View.result) return;

    // 게임시간 끝남.
    if (playTime <= 0) {
      setResult(0);
      return;
    }

    // TODO: implement update
    player.update(t);
    status.update(t);
    ais.forEach((Ai ai) => ai.update(t));

    if (isReadyCompleted()) {
      yh.update(t);
      playTime -= t;
      return;
    }

    if (activeView == View.playing) {
      readyTime -= t;
      return;
    }
  }

  isReadyCompleted() {
    if (activeView != View.playing) return false;
    return readyTime <= 0;
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  _screenRender(Canvas c) {
    if (activeView == View.home) homeView.render(c);
    if (activeView == View.result) resultView.render(c);

    buttonView.render(c);
  }

  _background(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffFFFFFF);
    canvas.drawRect(bgRect, bgPaint);

    background.render(canvas);
  }

  _setPlayer() {
    player = Player(this, screenSize);
  }

  _setAis() {
    ais = [];

    for (var i = 0; i <= 21; i++) {
      ais.add(Ai(this, i));
    }
  }

  _setNpc() {
    npcs = [];

    double size = screenSize.width / 5;
    npcs.add(Npc(this, size));
    npcs.add(Npc(this, size * 4));
  }

  _setYounghee() {
    yh = Yh(this);
  }

  void onTapDown(TapDownDetails d) {
    player.move();

    status.onTapDown(d);
    homeView.onTapDown(d);
    resultView.onTapDown(d);
    buttonView.onTapDown(d);
  }
}
