import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/screens/login_page.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/custm_elevated_button.dart';
import 'package:movies_app/utils/custm_text_form_field.dart';
import 'package:movies_app/utils/customTexButton.dart';
import 'package:movies_app/utils/customswitch.dart';

class Regstier_page extends StatelessWidget {
  Regstier_page({super.key});
  static const String regstierroute = '/regstier';
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List images = [AppImages.gamer1, AppImages.gamer2, AppImages.gamer3];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.primary),
        backgroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context)!.regster,
          style: AppStyles.primary20bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 100.0, // Slightly larger for effect
                  enlargeCenterPage: true,
                  viewportFraction: 0.50, // Show part of side avatars
                  enlargeStrategy: CenterPageEnlargeStrategy.values.last,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    // setState(() => selectedAvatar = index); // If using StatefulWidget
                  },
                ),
                items: images.map((imgPath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ), // Space between avatars
                        child: CircleAvatar(
                          radius:
                              48, // The center avatar will appear larger due to enlargeCenterPage
                          backgroundImage: AssetImage(imgPath),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.05),
              Text('Avatar ', style: AppStyles.white16_400),
              CustmTextFormField(
                controller: nameController,
                FilledTextStyle: AppStyles.white16_400,
                prefixIcon: ImageIcon(
                  AssetImage(AppImages.nameicon),
                  color: appColors.white,
                ),
                hintText: AppLocalizations.of(context)!.name,
                hintTextStyle: AppStyles.white16_400,
                foucsedBorderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                fillColor: appColors.grey,
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
                foucsedBorderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                fillColor: appColors.grey,
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
              CustmTextFormField(
                controller: confirmPasswordController,
                FilledTextStyle: AppStyles.white16_400,
                prefixIcon: ImageIcon(
                  AssetImage(AppImages.password_icon),
                  color: appColors.white,
                ),
                hintText: AppLocalizations.of(context)!.confirmpassword,
                hintTextStyle: AppStyles.white16_400,
                foucsedBorderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                fillColor: appColors.grey,
              ),
              SizedBox(height: height * 0.02),
              CustmTextFormField(
                controller: phoneController,
                FilledTextStyle: AppStyles.white16_400,
                prefixIcon: ImageIcon(
                  AssetImage(AppImages.phone_icon),
                  color: appColors.white,
                ),
                hintText: AppLocalizations.of(context)!.phonnumber,
                hintTextStyle: AppStyles.white16_400,
                foucsedBorderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                fillColor: appColors.grey,
              ),
              SizedBox(height: height * 0.04),
              Container(
                width: width * 0.9,
                height: height * 0.055,
                child: CustmElevatedButton(
                  onpressed: () {},
                  text: AppLocalizations.of(context)!.create_account,
                  styleOfChild: AppStyles.black16_400.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  BGcolor: appColors.primary,
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: AppStyles.white16_400,
                  ),
                  Customtextbutton(
                    onpressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginPage.loginroute,
                      );
                    },
                    text: AppLocalizations.of(context)!.login,
                    style: AppStyles.primary20bold,
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
