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
    apiKey: 'AIzaSyAD5HsqNsJsXBogZnIcdFbp6MEdpGYSPGs',
    appId: '1:926511270144:web:43bc0e49178a46d6a34be5',
    messagingSenderId: '926511270144',
    projectId: 'bitebox-79d22',
    authDomain: 'bitebox-79d22.firebaseapp.com',
    databaseURL: 'https://bitebox-79d22-default-rtdb.firebaseio.com',
    storageBucket: 'bitebox-79d22.appspot.com',
    measurementId: 'G-5R1403NRQ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByEF71yz7oW7I-4GyoKPzzCUNHb9SD-ic',
    appId: '1:926511270144:android:8f8099a64a771bf5a34be5',
    messagingSenderId: '926511270144',
    projectId: 'bitebox-79d22',
    databaseURL: 'https://bitebox-79d22-default-rtdb.firebaseio.com',
    storageBucket: 'bitebox-79d22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqJZEVyZMMPXMFrTwe13ld9PoSID6xwdc',
    appId: '1:926511270144:ios:2b1b5add3f4b83eaa34be5',
    messagingSenderId: '926511270144',
    projectId: 'bitebox-79d22',
    databaseURL: 'https://bitebox-79d22-default-rtdb.firebaseio.com',
    storageBucket: 'bitebox-79d22.appspot.com',
    iosBundleId: 'com.delta.lock',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqJZEVyZMMPXMFrTwe13ld9PoSID6xwdc',
    appId: '1:926511270144:ios:441d9a43f47612dea34be5',
    messagingSenderId: '926511270144',
    projectId: 'bitebox-79d22',
    databaseURL: 'https://bitebox-79d22-default-rtdb.firebaseio.com',
    storageBucket: 'bitebox-79d22.appspot.com',
    iosBundleId: 'com.example.lock.RunnerTests',
  );
}
