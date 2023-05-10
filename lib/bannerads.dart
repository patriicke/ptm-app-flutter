import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class BannerAdmob extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _BannerAdmobState();
//   }
// }

// class _BannerAdmobState extends State<BannerAdmob> {
//   BannerAd _bannerAd;
//   bool _bannerAdIsLoaded = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/6300978111'
//             : 'ca-app-pub-3940256099942544/2934735716',
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             print('$BannerAd loaded.');
//             setState(() {
//               _bannerAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             print('$BannerAd failedToLoad: $error');
//             setState(() {
//               _bannerAdIsLoaded = true;
//             });
//             ad.dispose();
//           },
//           onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//           onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//         ),
//         request: AdRequest())
//       ..load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _bannerAd.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (_bannerAdIsLoaded && _bannerAd != null)
//         ? Container(
//         height: _bannerAd.size.height.toDouble(),
//         width: _bannerAd.size.width.toDouble(),
//         child: AdWidget(ad: _bannerAd))
//         : Container();
//   }
// }