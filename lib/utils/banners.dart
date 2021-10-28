import 'package:flutter/foundation.dart' as Foundation;

class Banners {
  static interstitial() {
    if (Foundation.kReleaseMode) {
      return 'ca-app-pub-7575229700417196/2212979306';
    } else {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
  }
}
