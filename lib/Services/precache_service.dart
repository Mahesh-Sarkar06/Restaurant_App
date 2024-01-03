
import 'package:flutter/material.dart';

class PreCacheImages {
  static Future<void> preCacheImages(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage('assets/images/Plate-1.png'), context),
      precacheImage(const AssetImage('assets/images/Plate-1-alt.png'), context),
      precacheImage(const AssetImage('assets/images/Plate-2.png'), context),
      precacheImage(const AssetImage('assets/images/Plate-2-alt.png'), context),
      precacheImage(const AssetImage('assets/images/Plate-3.png'), context),
      precacheImage(const AssetImage('assets/images/Plate-3-alt.png'), context),
    ]);
  }
}