import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
///
///     import 'firebase_options.dart';
///     // ...
///     await Firebase.initializeApp(
///       options: DefaultFirebaseOptions.currentPlatform,
///     );
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
          'you can reconfigure this project by running the FlutterFire CLI '
          'again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this project by running the FlutterFire CLI '
          'again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    appId: "YOUR_APP_ID",
    messagingSenderId: "YOUR_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    authDomain: "YOUR_AUTH_DOMAIN",
    storageBucket: "YOUR_STORAGE_BUCKET",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDWSbLH6TcZWY-2pII_YGGRX2fxfvxf0zE",
    appId: "1:582534604886:android:dd2322d2860cf18f9933f7",
    messagingSenderId: "582534604886",
    projectId: "me-pro-15075",
    storageBucket: "me-pro-15075.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyAZEdBxL6N92d6oxhkZsMygAtvadEZXmYY",
    appId: "1:582534604886:ios:84c550fd3493f4759933f7",
    messagingSenderId: "582534604886",
    projectId: "me-pro-15075",
    storageBucket: "me-pro-15075.firebasestorage.app",
    iosBundleId: "com.ilyes.doctor",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    appId: "YOUR_APP_ID",
    messagingSenderId: "YOUR_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    iosBundleId: "YOUR_IOS_BUNDLE_ID",
  );
}
