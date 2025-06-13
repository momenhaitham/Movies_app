import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/home_screen.dart';
import 'package:movies_app/intro_pages/intro_screen2.dart';
import 'package:movies_app/intro_pages/intro_screen3.dart';
import 'package:movies_app/intro_pages/intro_screen4.dart';
import 'package:movies_app/intro_pages/intro_screen5.dart';
import 'package:movies_app/intro_pages/intro_screen6.dart';
import 'package:movies_app/providers/app_provider.dart';
import 'package:movies_app/screens/forgotpassword.dart';
import 'package:movies_app/screens/login_screen/login_page.dart';
import 'package:movies_app/screens/register_screen/regstier.dart';
import 'package:provider/provider.dart';
import 'Tabs/profile_tab/EditProfileTab/edit_profile_screen.dart';
import 'Tabs/profile_tab/EditProfileTab/reset_password_screen.dart';
import 'intro_pages/intro_screen1.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child:  EasyLocalization(
          supportedLocales: [Locale('en'),Locale('ar')],
          path: 'assets/translations', // <-- change the path of the translation files
          child: MyApp()
      ),
    ),
  );
}

class MyApp extends StatefulWidget {

   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppProvider provider;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      provider.ReadLocal();
      provider.ReadTokin();
     await provider.GetProfileData(provider.CurrentUserTokin!);
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    if(provider.ProfileData==null&&provider.CurrentUserTokin!=null){
      provider.GetProfileData(provider.CurrentUserTokin!);
    }
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(provider.CurrentLocal??"en"),
      themeMode: ThemeMode.dark,
      initialRoute:provider.CurrentUserTokin==null? LoginPage.loginroute:HomeScreen.routeName,
      routes: {
        IntroScreen1.routeName: (context) => IntroScreen1(),
        IntroScreen2.routeName: (context) => IntroScreen2(),
        IntroScreen3.routeName: (context) => IntroScreen3(),
        IntroScreen4.routeName: (context) => IntroScreen4(),
        IntroScreen5.routeName: (context) => IntroScreen5(),
        IntroScreen6.routeName: (context) => IntroScreen6(),
        HomeScreen.routeName: (context)=> HomeScreen(),
        EditProfileScreen.routeName: (context)=> EditProfileScreen(),
        LoginPage.loginroute: (context) => LoginPage(),
        Regstier_page.regstierroute: (context) => Regstier_page(),
        ForgotPassWord.forgotPasswordRoute: (context) => ForgotPassWord(),
        ResetPasswordScreen.routeName:(context)=>ResetPasswordScreen()
      },
    );
  }
}
