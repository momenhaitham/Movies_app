import 'package:flutter/material.dart';
import 'package:movies_app/intro_pages/intro_screen2.dart';

import 'intro_pages/intro_screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      initialRoute:IntroScreen1.routeName,
      routes: {
        IntroScreen1.routeName: (context)=>IntroScreen1(),
        IntroScreen2.routeName: (context)=>IntroScreen2(),

      },
    );
  }
}

