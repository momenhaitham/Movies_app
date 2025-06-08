// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get welcome => 'Welcome to our application!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get error_invalid_credentials => 'Invalid email or password.';

  @override
  String get confirmpassword => 'Confirm Password';

  @override
  String get name => 'Name';

  @override
  String get regster => 'Register';

  @override
  String get create_account => 'Create an Account';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get phonnumber => 'Phone Number';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get loginwith_google => 'Login with Google';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get verfy_email => 'Verify your email';

  @override
  String get or => 'or';
}
