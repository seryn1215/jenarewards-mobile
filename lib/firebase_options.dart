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
    apiKey: 'AIzaSyAHRooJWMAjz1taXv8nq7BXkTmlm0JeQ_g',
    appId: '1:167885748169:web:9586af2949917e23905a18',
    messagingSenderId: '167885748169',
    projectId: 'capsule-rewards',
    authDomain: 'capsule-rewards.firebaseapp.com',
    storageBucket: 'capsule-rewards.appspot.com',
    measurementId: 'G-GEX5KWKG4D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKjyWuBysSg1rT34Yk21E0gKgXHo-Ci1M',
    appId: '1:167885748169:android:b2fb765730a59351905a18',
    messagingSenderId: '167885748169',
    projectId: 'capsule-rewards',
    storageBucket: 'capsule-rewards.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8A8_RT84kG8kWfi_XDQ3A95BQQZSNEoc',
    appId: '1:167885748169:ios:7793fb3a19a6628b905a18',
    messagingSenderId: '167885748169',
    projectId: 'capsule-rewards',
    storageBucket: 'capsule-rewards.appspot.com',
    iosClientId: '167885748169-7ha3cocacfci68as3friaauip789t2gs.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterGetxBoilerplate',
  );
}
