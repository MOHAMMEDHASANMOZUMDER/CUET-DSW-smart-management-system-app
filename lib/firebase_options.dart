// Generated from the Android Firebase configuration in
// android/app/google-services.json.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Firebase web configuration is not included in this repository.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are only configured for Android.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCDPlqNk3UTkzRKh7o-guqp0KyNuJ-1uw',
    appId: '1:693483342941:android:1671cde32380df44fd51b4',
    messagingSenderId: '693483342941',
    projectId: 'cuet-dsw-smart-service',
    storageBucket: 'cuet-dsw-smart-service.firebasestorage.app',
  );
}
