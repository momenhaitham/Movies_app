import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../Reusable_widgets/custm_elevated_button.dart';
import '../Reusable_widgets/custm_text_form_field.dart';


class ForgotPassWord extends StatelessWidget {
  ForgotPassWord({super.key});
  static const String forgotPasswordRoute = '/forgot_password';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.primary),
        backgroundColor: Colors.black,
        title: Text(
          "forgot_password".tr(),
          style: AppStyles.primary20bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.95,
            height: height * 0.45,
            child: Image.asset(AppImages.forgort_password),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustmTextFormField(
              prefixIcon: ImageIcon(
                AssetImage(AppImages.email_icon),
                color: appColors.white,
              ),
              hintText: "email".tr(),
              hintTextStyle: AppStyles.white16_400,
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width * 0.9,
            height: height * 0.055,
            child: CustmElevatedButton(
              onpressed: () {},
              text: "verfy_email".tr(),
              styleOfChild: AppStyles.black16_400.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              BGcolor: appColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
