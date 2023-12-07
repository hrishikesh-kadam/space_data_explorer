// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
// coverage:ignore-file

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'dev.dart';
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA2Kd-QCbFhEbEgR1PlCkcoozrLgZ2VY-w',
    appId: '1:1030109759765:web:8c3a343b4a1c6ea46b811c',
    messagingSenderId: '1030109759765',
    projectId: 'space-data-explorer-dev',
    authDomain: 'space-data-explorer-dev.firebaseapp.com',
    storageBucket: 'space-data-explorer-dev.appspot.com',
    measurementId: 'G-HEQLD4F2M5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP4PtcOie6srwnCQjf9aUBImNJ7qs61z8',
    appId: '1:1030109759765:android:851590128c8b32c76b811c',
    messagingSenderId: '1030109759765',
    projectId: 'space-data-explorer-dev',
    storageBucket: 'space-data-explorer-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9moZPaMpvenL_4v2GvOOz5o17Iltvrnc',
    appId: '1:1030109759765:ios:ae1cbbb17367775b6b811c',
    messagingSenderId: '1030109759765',
    projectId: 'space-data-explorer-dev',
    storageBucket: 'space-data-explorer-dev.appspot.com',
    iosBundleId: 'dev.hrishikesh-kadam.flutter.space-data-explorer.dev',
  );
}
