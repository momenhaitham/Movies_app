import 'package:flutter/material.dart';
import 'package:movies_app/intro_pages/intro_screen2.dart';
import 'package:movies_app/intro_pages/intro_screen3.dart';
import 'package:movies_app/intro_pages/intro_screen4.dart';
import 'package:movies_app/intro_pages/intro_screen5.dart';
import 'package:movies_app/intro_pages/intro_screen6.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/providers/langueprovider.dart';
import 'package:movies_app/screens/forgotpassword.dart';
import 'package:movies_app/screens/login_page.dart';
import 'package:movies_app/screens/regstier.dart';
import 'package:provider/provider.dart';
import 'intro_pages/intro_screen1.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
 runApp(
    ChangeNotifierProvider(
      create: (_) => LangProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LangProvider>(context);
    return MaterialApp(
      locale: langProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,

      themeMode: ThemeMode.dark,
      initialRoute: LoginPage.loginroute,
      routes: {
        IntroScreen1.routeName: (context) => IntroScreen1(),
        IntroScreen2.routeName: (context) => IntroScreen2(),
        IntroScreen3.routeName: (context) => IntroScreen3(),
        IntroScreen4.routeName: (context) => IntroScreen4(),
        IntroScreen5.routeName: (context) => IntroScreen5(),
        IntroScreen6.routeName: (context) => IntroScreen6(),
        LoginPage.loginroute: (context) => LoginPage(),
        Regstier_page.regstierroute: (context) => Regstier_page(),
        ForgotPassWord.forgotPasswordRoute: (context) => ForgotPassWord(),
      },
    );
  }
}
