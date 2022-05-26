// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBIbJnZ4PhUD4mJ-eBpKeD9koJ-BJDWKtU',
    appId: '1:890691321939:web:f3d2d5ffcd6fc12ada86a6',
    messagingSenderId: '890691321939',
    projectId: 'expensetrackerapp-9617f',
    authDomain: 'expensetrackerapp-9617f.firebaseapp.com',
    storageBucket: 'expensetrackerapp-9617f.appspot.com',
    measurementId: 'G-01NJ84P6BF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX156LIdZtkKM9gXiV7aO1f1pbzdYAXuU',
    appId: '1:890691321939:android:04a925fe992d2775da86a6',
    messagingSenderId: '890691321939',
    projectId: 'expensetrackerapp-9617f',
    storageBucket: 'expensetrackerapp-9617f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB64K-VyKjRDznahPOms9eyKcH4nInl44g',
    appId: '1:890691321939:ios:60cccafcbc5d528eda86a6',
    messagingSenderId: '890691321939',
    projectId: 'expensetrackerapp-9617f',
    storageBucket: 'expensetrackerapp-9617f.appspot.com',
    androidClientId: '890691321939-ieshbbun047qeuncmqgf4dhn3lq6q3q8.apps.googleusercontent.com',
    iosClientId: '890691321939-s551f0p08uhn8dc2hifc81g5oql85hgj.apps.googleusercontent.com',
    iosBundleId: 'com.sptpra.expenseTracker',
  );
}
