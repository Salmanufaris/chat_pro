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
    apiKey: 'AIzaSyDNP2JdTnVhNiwyPLPCiIIcOcac15tOQCk',
    appId: '1:401882858246:web:498ac9bdc0e0fdc94fd487',
    messagingSenderId: '401882858246',
    projectId: 'chatapp-263df',
    authDomain: 'chatapp-263df.firebaseapp.com',
    storageBucket: 'chatapp-263df.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANVe5qPZyiNjYG0yhxZdcjeGhFAs_lG4E',
    appId: '1:401882858246:android:f3e2d20e39b85f434fd487',
    messagingSenderId: '401882858246',
    projectId: 'chatapp-263df',
    storageBucket: 'chatapp-263df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjNPguI1nCGXCi0NkOnxbAt-4pVQNPcsc',
    appId: '1:401882858246:ios:d77da06c5739406f4fd487',
    messagingSenderId: '401882858246',
    projectId: 'chatapp-263df',
    storageBucket: 'chatapp-263df.appspot.com',
    androidClientId: '401882858246-17rflgsg84oj72us9hnsrt4qtcivvt5n.apps.googleusercontent.com',
    iosClientId: '401882858246-vgkbu20fnjlcclgamqk3n7ojkcfaqbb4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjNPguI1nCGXCi0NkOnxbAt-4pVQNPcsc',
    appId: '1:401882858246:ios:59ac5c81c5f67ad04fd487',
    messagingSenderId: '401882858246',
    projectId: 'chatapp-263df',
    storageBucket: 'chatapp-263df.appspot.com',
    androidClientId: '401882858246-17rflgsg84oj72us9hnsrt4qtcivvt5n.apps.googleusercontent.com',
    iosClientId: '401882858246-tu36hvm9ienn3us0msdtars1jhnlu4b4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
