import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyAjmKR9BIR23-DdMiTiS1_HbPgG1stQ_-U',
    appId: '1:467149179341:web:b882b3073f1e52a7ff5c84',
    messagingSenderId: '467149179341',
    projectId: 'quick-view-ea794',
    databaseURL:
        'https://spe-data-3fd17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'quick-view-ea794.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjmKR9BIR23-DdMiTiS1_HbPgG1stQ_-U',
    appId: '1:467149179341:web:b882b3073f1e52a7ff5c84',
    messagingSenderId: '467149179341',
    projectId: 'quick-view-ea794',
    databaseURL:
        'https://spe-data-3fd17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'quick-view-ea794.appspot.com',
    iosClientId:
        '458757187364-gnk3ijtuc85jkcigqp78lgnjslhgldvq.apps.googleusercontent.com',
    iosBundleId: 'com.example.RewardProcessing',
  );
}
