import 'package:flutter/foundation.dart' as Foundation;
import 'package:games_services/games_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storages {
  static String aosLeaderboardID = 'CgkI4YOWjdYYEAIQAg';
  static String iosLeaderboardID = 'CgkI4YOWjdYYEAIQAg';

  static getBestTime() async {
    final key = 'best';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int best = prefs.getInt(key) ?? 120;
    return best;
  }

  static success(int second) async {
    _successCount();
    return await _highscore(second);
  }

  static failed(int second) async {
    _failCount();
  }

  static sound(int sound) async {
    final key = 'sound';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (sound >= 0) {
      await prefs.setInt(key, sound).then((value) => null);
    } else {
      sound = prefs.getInt(key) ?? 1;
    }

    return sound;
  }

  static _highscore(int second) async {
    final key = 'best';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int prevSecond = prefs.getInt(key) ?? 120;

    if (second >= prevSecond) return prevSecond;

    prefs.setInt(key, second).then((value) => null);
    GamesServices.submitScore(
            score: Score(
                androidLeaderboardID: aosLeaderboardID,
                // iOSLeaderboardID: iosLeaderboardID,
                value: second))
        .then((value) => null);

    return second;
  }

  static _successCount() async {
    const data = {
      1: ['CgkI4YOWjdYYEAIQAw', 'CgkI4YOWjdYYEAIQAw'],
      5: ['CgkI4YOWjdYYEAIQCw', 'CgkI4YOWjdYYEAIQCw'],
      10: ['CgkI4YOWjdYYEAIQBQ', 'CgkI4YOWjdYYEAIQBQ'],
      20: ['CgkI4YOWjdYYEAIQDA', 'CgkI4YOWjdYYEAIQDA'],
      30: ['CgkI4YOWjdYYEAIQDQ', 'CgkI4YOWjdYYEAIQDQ'],
      50: ['CgkI4YOWjdYYEAIQBg', 'CgkI4YOWjdYYEAIQBg'],
      70: ['CgkI4YOWjdYYEAIQDg', 'CgkI4YOWjdYYEAIQDg'],
      100: ['CgkI4YOWjdYYEAIQBw', 'CgkI4YOWjdYYEAIQBw'],
    };

    final key = 'success';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = (prefs.getInt(key) ?? 0) + 1;

    prefs.setInt(key, count).then((value) => null);
    var achievement = data[count];
    if (achievement != null) {
      GamesServices.unlock(
          achievement: Achievement(
              androidID: achievement[0],
              // iOSID: achievement[1],
              percentComplete: 100));
    }
  }

  static _failCount() async {
    const data = {
      1: ['CgkI4YOWjdYYEAIQBA', 'CgkI4YOWjdYYEAIQBA'],
      5: ['CgkI4YOWjdYYEAIQDw', 'CgkI4YOWjdYYEAIQDw'],
      10: ['CgkI4YOWjdYYEAIQCA', 'CgkI4YOWjdYYEAIQCA'],
      20: ['CgkI4YOWjdYYEAIQEA', 'CgkI4YOWjdYYEAIQEA'],
      30: ['CgkI4YOWjdYYEAIQEQ', 'CgkI4YOWjdYYEAIQEQ'],
      50: ['CgkI4YOWjdYYEAIQCQ', 'CgkI4YOWjdYYEAIQCQ'],
      70: ['CgkI4YOWjdYYEAIQEg', 'CgkI4YOWjdYYEAIQEg'],
      100: ['CgkI4YOWjdYYEAIQEg', 'CgkI4YOWjdYYEAIQEg'],
    };

    final key = 'failed';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = (prefs.getInt(key) ?? 0) + 1;

    prefs.setInt(key, count).then((value) => null);
    var achievement = data[count];
    if (achievement != null) {
      GamesServices.unlock(
          achievement: Achievement(
              androidID: achievement[0],
              // iOSID: achievement[1],
              percentComplete: 100));
    }
  }
}
