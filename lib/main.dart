import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'app_theme.dart';
import 'signup_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase Initialization
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDzMDgz6N7YhjyGoVK6GQdtNDx6vws_7QY",                //  From Firebase console
        authDomain: "book-now-85b88.firebaseapp.com",
        projectId: "book-now-85b88",
        storageBucket: "book-now-85b88.appspot.com",
        messagingSenderId: "686729302252",
        appId: "1:686729302252:web:c7f452a5c7abc196e795c9",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Management',
      home: LoginPage(),
      routes: {
        LoginPage.tag: (context) => LoginPage(),
        SignUpPage.tag: (context) => SignUpPage(),
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
