import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get interstitialAdUnitId {
    if (kIsWeb) {
      return '';
    }
    final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
    if (kDebugMode) {
      // Use test IDs during development (always show demo ads on physical devices)
      return isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712' // Android test interstitial
          : 'ca-app-pub-3940256099942544/4411468910'; // iOS test interstitial
    }
    // Use real IDs for production
    return isAndroid
        ? 'ca-app-pub-3286434692968748/1750922400' // Android real interstitial
        : 'ca-app-pub-3286434692968748/3290508437'; // iOS real interstitial
  }

  static Future<void> showInterstitialAd({
    required VoidCallback onAdDismissed,
    required VoidCallback onAdFailed,
  }) async {
    if (kIsWeb) {
      debugPrint('Ads are not supported on web; continuing without ad.');
      onAdFailed();
      return;
    }
    debugPrint('Loading and showing interstitial ad...');
    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('Ad loaded, showing...');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Ad dismissed');
              ad.dispose();
              onAdDismissed(); // Trigger navigation
            },
            onAdFailedToShowFullScreenContent: (ad, AdError error) {
              debugPrint('Ad failed to show: ${error.message}');
              ad.dispose();
              onAdFailed(); // Trigger navigation anyway
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Ad failed to load: ${error.message}');
          onAdFailed(); // Trigger navigation anyway
        },
      ),
    );
  }
}