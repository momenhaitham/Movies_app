import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movies_app/providers/langueprovider.dart';
import 'package:movies_app/screens/forgotpassword.dart';
import 'package:movies_app/screens/regstier.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/custm_elevated_button.dart';
import 'package:movies_app/utils/custm_text_form_field.dart';
import 'package:movies_app/utils/customTexButton.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/customswitch.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String loginroute = '/login';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var widht = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Container(
            color: appColors.black,
            child: Column(
              children: [
                SizedBox(height: height * 0.05),
                SizedBox(
                  height: height * 0.22,
                  width: widht * 0.25,
                  child: Image(image: AssetImage(AppImages.login_logo)),
                ),
                SizedBox(height: height * 0.02),
                CustmTextFormField(
                  controller: emailController,
                  FilledTextStyle: AppStyles.white16_400,
                  prefixIcon: ImageIcon(
                    AssetImage(AppImages.email_icon),
                    color: appColors.white,
                  ),
                  hintText: AppLocalizations.of(context)!.email,
                  hintTextStyle: AppStyles.white16_400,
                  fillColor: appColors.grey,

                  foucsedBorderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                ),
                SizedBox(height: height * 0.02),
                CustmTextFormField(
                  controller: passwordController,
                  FilledTextStyle: AppStyles.white16_400,
                  prefixIcon: ImageIcon(
                    AssetImage(AppImages.password_icon),
                    color: appColors.white,
                  ),
                  hintText: AppLocalizations.of(context)!.password,
                  hintTextStyle: AppStyles.white16_400,
                  foucsedBorderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  fillColor: appColors.grey,
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.centerRight,
                  child: Customtextbutton(
                    onpressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgotPassWord.forgotPasswordRoute,
                      );
                    },
                    text: AppLocalizations.of(context)!.forgot_password,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: appColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: widht * 0.9,
                  height: height * 0.055,
                  child: CustmElevatedButton(
                    onpressed: () {},
                    text: AppLocalizations.of(context)!.login,
                    styleOfChild: AppStyles.black16_400.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    BGcolor: appColors.primary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_account,
                      style: AppStyles.white16_400,
                    ),
                    Customtextbutton(
                      onpressed: () {
                        Navigator.pushNamed(
                          context,
                          Regstier_page.regstierroute,
                        );
                      },
                      text: AppLocalizations.of(context)!.create_account,
                      style: AppStyles.primary20bold,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: appColors.primary,
                        thickness: 1,
                        indent: widht * 0.05,
                        endIndent: widht * 0.05,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyles.white16_400.copyWith(
                        color: appColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: appColors.primary,
                        thickness: 1,
                        indent: widht * 0.05,
                        endIndent: widht * 0.05,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: widht * 0.9,
                  height: height * 0.055,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage(AppImages.google_icon),
                          color: Colors.black,
                          size: 30,
                        ),
                        Text(
                          AppLocalizations.of(context)!.loginwith_google,
                          style: AppStyles.black16_400.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
