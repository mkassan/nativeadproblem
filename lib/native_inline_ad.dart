
import 'ad_helper.dart';
// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';

class NativeInlineAd extends StatefulWidget {
  NativeInlineAd();
  @override
  State createState() => _NativeInlineAdState();
}

class _NativeInlineAdState extends State<NativeInlineAd> with AutomaticKeepAliveClientMixin {
  // COMPLETE: Add NativeAd instance
  late NativeAd _ad;
  // COMPLETE: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // COMPLETE: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdManager.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // COMPLETE: Load an ad
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded) {
      return Container(
        child: AdWidget(ad: _ad),
        height: 72.0,
        alignment: Alignment.center,
      );
    }
    return Container(
      height: 72.0,
      child: Placeholder(),
    );
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
