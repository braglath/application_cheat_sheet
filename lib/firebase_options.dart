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
    apiKey: 'AIzaSyB2s-Vans901wKXdh_ETbddgg4lpHX94Us',
    appId: '1:565572909556:web:e76ac19a162ff7a0fc21a1',
    messagingSenderId: '565572909556',
    projectId: 'application-cheetsheets',
    authDomain: 'application-cheetsheets.firebaseapp.com',
    storageBucket: 'application-cheetsheets.firebasestorage.app',
    measurementId: 'G-L3L12RCWKP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWJWJXD4uLVTKkhRjjCggdk_vxLKa1nmc',
    appId: '1:565572909556:android:be0b9eb4b73fa31bfc21a1',
    messagingSenderId: '565572909556',
    projectId: 'application-cheetsheets',
    storageBucket: 'application-cheetsheets.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9Dv1y7lSBi4oH7NXX8qopAS-E4dJXesY',
    appId: '1:565572909556:ios:83d7ab803003dedbfc21a1',
    messagingSenderId: '565572909556',
    projectId: 'application-cheetsheets',
    storageBucket: 'application-cheetsheets.firebasestorage.app',
    iosBundleId: 'com.flutterzone.applicationCheatsheets',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9Dv1y7lSBi4oH7NXX8qopAS-E4dJXesY',
    appId: '1:565572909556:ios:83d7ab803003dedbfc21a1',
    messagingSenderId: '565572909556',
    projectId: 'application-cheetsheets',
    storageBucket: 'application-cheetsheets.firebasestorage.app',
    iosBundleId: 'com.flutterzone.applicationCheatsheets',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2s-Vans901wKXdh_ETbddgg4lpHX94Us',
    appId: '1:565572909556:web:9baa4eac259dfe79fc21a1',
    messagingSenderId: '565572909556',
    projectId: 'application-cheetsheets',
    authDomain: 'application-cheetsheets.firebaseapp.com',
    storageBucket: 'application-cheetsheets.firebasestorage.app',
    measurementId: 'G-V3C473TS9K',
  );

}