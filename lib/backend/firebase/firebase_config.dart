import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDZSOKdHwBBYXPvBgCxV5w3kHJSV-N3rYI",
            authDomain: "ijf-mobile.firebaseapp.com",
            projectId: "ijf-mobile",
            storageBucket: "ijf-mobile.appspot.com",
            messagingSenderId: "538929974877",
            appId: "1:538929974877:web:8617391afeb00af8e1c7b4"));
  } else {
    await Firebase.initializeApp();
  }
}
