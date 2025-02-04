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
        return macos;
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
    apiKey: 'AIzaSyD__u2b9ARPzluz6ulvUfdY2stwkL0cCgQ',
    appId: '1:555238924748:web:a9820873c4cbf6c11b7d69',
    messagingSenderId: '555238924748',
    projectId: 'budget-worker',
    authDomain: 'budget-worker.firebaseapp.com',
    storageBucket: 'budget-worker.appspot.com',
    measurementId: 'G-440HYSV5KR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaVCGMFRAycYTLHz3iieHWUMMaabpz680',
    appId: '1:555238924748:android:272dd4202c93b4331b7d69',
    messagingSenderId: '555238924748',
    projectId: 'budget-worker',
    storageBucket: 'budget-worker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvEQR7ZzlvAjJB0ZJjEjc0Alh9_AcMjd4',
    appId: '1:555238924748:ios:0e26d4d0ae1bb8871b7d69',
    messagingSenderId: '555238924748',
    projectId: 'budget-worker',
    storageBucket: 'budget-worker.appspot.com',
    iosClientId: '555238924748-3ojadjcr4glrdu0qc402jd9hcib4aqi2.apps.googleusercontent.com',
    iosBundleId: 'com.example.workerBudgetWorker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvEQR7ZzlvAjJB0ZJjEjc0Alh9_AcMjd4',
    appId: '1:555238924748:ios:0e26d4d0ae1bb8871b7d69',
    messagingSenderId: '555238924748',
    projectId: 'budget-worker',
    storageBucket: 'budget-worker.appspot.com',
    iosClientId: '555238924748-3ojadjcr4glrdu0qc402jd9hcib4aqi2.apps.googleusercontent.com',
    iosBundleId: 'com.example.workerBudgetWorker',
  );
}
