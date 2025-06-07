import 'package:flutter/material.dart';
import 'package:movies_app/intro_pages/intro_screen2.dart';
import 'package:movies_app/intro_pages/intro_screen3.dart';
import 'package:movies_app/intro_pages/intro_screen4.dart';
import 'package:movies_app/intro_pages/intro_screen5.dart';
import 'package:movies_app/intro_pages/intro_screen6.dart';
import 'package:movies_app/utils/app_theme.dart';

import 'home_screen.dart';
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
      darkTheme: AppTheme.DarkTheme,
      themeMode: ThemeMode.dark,
      initialRoute:IntroScreen1.routeName,
      routes: {
        IntroScreen1.routeName: (context)=>IntroScreen1(),
        IntroScreen2.routeName: (context)=>IntroScreen2(),
        IntroScreen3.routeName: (context)=>IntroScreen3(),
        IntroScreen4.routeName: (context)=>IntroScreen4(),
        IntroScreen5.routeName: (context)=>IntroScreen5(),
        IntroScreen6.routeName: (context)=>IntroScreen6(),
        HomeScreen.routeName: (context)=>HomeScreen(),
      },
    );
  }
}

