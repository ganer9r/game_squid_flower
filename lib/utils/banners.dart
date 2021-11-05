import 'dart:io';

import 'package:flutter/foundation.dart' as Foundation;

class Banners {
  static interstitial() {
    if (Foundation.kReleaseMode) {
      if (Platform.isAndroid) {
        // android
        return 'ca-app-pub-7575229700417196/2212979306';
      } else {
        // ios
        return 'ca-app-pub-7575229700417196/3726193336';
      }
    } else {
      if (Platform.isAndroid) {
        // android
        return 'ca-app-pub-3940256099942544/1033173712';
      } else {
        // ios
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    }
  }
}
