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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMXY7MEikxxzpk3x004tSebxfTHLQYzs4',
    appId: '1:568099022037:android:125e03a06832f372672e5c',
    messagingSenderId: '568099022037',
    projectId: 'loja-virtual-f8768',
    databaseURL: 'https://loja-virtual-f8768-default-rtdb.firebaseio.com',
    storageBucket: 'loja-virtual-f8768.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAIWRX3UwOi79W1qm3YCugw-x3wWnTgMg',
    appId: '1:568099022037:ios:75d671ac9164cea3672e5c',
    messagingSenderId: '568099022037',
    projectId: 'loja-virtual-f8768',
    databaseURL: 'https://loja-virtual-f8768-default-rtdb.firebaseio.com',
    storageBucket: 'loja-virtual-f8768.appspot.com',
    androidClientId: '568099022037-0avjf87ep8r87g0nq5pesvv82l077lbq.apps.googleusercontent.com',
    iosClientId: '568099022037-53uuatb1rlcfr261tlpc4jl6p5kmlr0b.apps.googleusercontent.com',
    iosBundleId: 'com.joaojordan.lojaVirtual',
  );
}
