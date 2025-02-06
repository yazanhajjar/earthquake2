// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjagFZRaDZka9HtaXBDTPxDRCtvZTQNYI',
    appId: '1:629949559507:web:22dea2839b1e47b6b41a26',
    messagingSenderId: '629949559507',
    projectId: 'earthquake-notifications',
    authDomain: 'earthquake-notifications.firebaseapp.com',
    storageBucket: 'earthquake-notifications.firebasestorage.app',
    measurementId: 'G-Q0VX0Z4LMR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAw3Kc0BkqQ7E3eEydLTyP5clulTGEU03Y',
    appId: '1:629949559507:android:76a0380da765ead8b41a26',
    messagingSenderId: '629949559507',
    projectId: 'earthquake-notifications',
    storageBucket: 'earthquake-notifications.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbhu0m0yTQgQsbEKBtfbTxe-Cg4Z6Nu4U',
    appId: '1:629949559507:ios:af003e3f722b80b7b41a26',
    messagingSenderId: '629949559507',
    projectId: 'earthquake-notifications',
    storageBucket: 'earthquake-notifications.firebasestorage.app',
    iosBundleId: 'com.example.earthquakeProtection',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbhu0m0yTQgQsbEKBtfbTxe-Cg4Z6Nu4U',
    appId: '1:629949559507:ios:af003e3f722b80b7b41a26',
    messagingSenderId: '629949559507',
    projectId: 'earthquake-notifications',
    storageBucket: 'earthquake-notifications.firebasestorage.app',
    iosBundleId: 'com.example.earthquakeProtection',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjagFZRaDZka9HtaXBDTPxDRCtvZTQNYI',
    appId: '1:629949559507:web:f650aa2faeb10d9cb41a26',
    messagingSenderId: '629949559507',
    projectId: 'earthquake-notifications',
    authDomain: 'earthquake-notifications.firebaseapp.com',
    storageBucket: 'earthquake-notifications.firebasestorage.app',
    measurementId: 'G-5TXPPWLNY8',
  );
}
