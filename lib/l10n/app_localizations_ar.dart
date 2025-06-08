// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get welcome => 'مرحبًا بك في تطبيقنا!';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get error_invalid_credentials => 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get confirmpassword => 'تأكيد كلمة المرور';

  @override
  String get name => 'الاسم';

  @override
  String get regster => 'تسجيل';

  @override
  String get create_account => 'إنشاء حساب';

  @override
  String get forgot_password => 'هل نسيت كلمة المرور؟';

  @override
  String get phonnumber => 'رقم الهاتف';

  @override
  String get reset_password => 'إعادة تعيين كلمة المرور';

  @override
  String get loginwith_google => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get already_have_account => 'هل لديك حساب بالفعل؟';

  @override
  String get dont_have_account => 'ليس لديك حساب؟';

  @override
  String get verfy_email => 'تأكيد بريدك الإلكتروني';

  @override
  String get or => 'أو';
}
