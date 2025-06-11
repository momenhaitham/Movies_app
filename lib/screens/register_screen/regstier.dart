import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/screens/login_screen/login_page.dart';
import 'package:movies_app/screens/register_screen/register_states.dart';
import 'package:movies_app/screens/register_screen/register_view_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import 'package:movies_app/Reusable_widgets/customTexButton.dart';
import 'package:movies_app/Reusable_widgets/customswitch.dart';
import 'package:provider/provider.dart';

import '../../Reusable_widgets/custm_elevated_button.dart';
import '../../Reusable_widgets/custm_text_form_field.dart';
import '../../Reusable_widgets/show_dialog_utils.dart';
import '../../providers/app_provider.dart';

class Regstier_page extends StatefulWidget {
  Regstier_page({super.key});
  static const String regstierroute = '/regstier';

  @override
  State<Regstier_page> createState() => _Regstier_pageState();
}

class _Regstier_pageState extends State<Regstier_page> {
  final formKey = GlobalKey<FormState>();

  var registerViewModel=RegisterViewModel();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final phoneController = TextEditingController();

  int selectedAvatar = 0;

  int currentSelected = 0;

  int error =0;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    currentSelected =provider.CurrentLocal=="en"? 0:1;
    return BlocProvider(
      create: (context)=>registerViewModel,
      child: BlocConsumer<RegisterViewModel,RegisterStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              iconTheme: IconThemeData(color: appColors.primary),
              backgroundColor: Colors.black,
              title: Text(
                "regster".tr(),
                style: AppStyles.primary20bold,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
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
                            selectedAvatar = index;
                          },
                        ),
                        items: provider.images.map((imgPath) {
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
                        validation: (text){
                          if(text==null||text.isEmpty){
                            return "Please Enter Your Name";
                          }else if(text.length<12){
                            return "Enter a Valid Name";
                          }

                        },
                        controller: nameController,
                        FilledTextStyle: AppStyles.white16_400,
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.nameicon),
                          color: appColors.white,
                        ),
                        hintText: "name".tr(),
                        hintTextStyle: AppStyles.white16_400,
                        foucsedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        fillColor: appColors.grey,
                      ),
                      SizedBox(height: height * 0.02),
                      CustmTextFormField(
                        validation: (text){
                          if(text==null||text.isEmpty)
                          {
                            return "you must enter your email".tr();
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if(emailValid==false)
                          {
                            return "not correct email".tr();
                          }
                        },
                        controller: emailController,
                        FilledTextStyle: AppStyles.white16_400,
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.email_icon),
                          color: appColors.white,
                        ),
                        hintText: "email".tr(),
                        hintTextStyle: AppStyles.white16_400,
                        foucsedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        fillColor: appColors.grey,
                      ),
                      SizedBox(height: height * 0.02),
                      CustmTextFormField(
                        validation: (value){
                          RegExp regex =
                          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value==null||value.isEmpty) {
                            return 'Please enter password';
                          } else {
                            if (!regex.hasMatch(value)) {
                              return 'Enter valid password';
                            } else {
                              return null;
                            }
                          }
                        },
                        controller: passwordController,
                        FilledTextStyle: AppStyles.white16_400,
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.password_icon),
                          color: appColors.white,
                        ),
                        hintText: "password".tr(),
                        hintTextStyle: AppStyles.white16_400,
                        foucsedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        fillColor: appColors.grey,
                      ),
                      SizedBox(height: height * 0.02),
                      CustmTextFormField(
                        validation: (text){
                          if(text != passwordController.text){
                            return "Dose Not Match PassWord";
                          }
                        },
                        controller: confirmPasswordController,
                        FilledTextStyle: AppStyles.white16_400,
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.password_icon),
                          color: appColors.white,
                        ),
                        hintText: "confirmpassword".tr(),
                        hintTextStyle: AppStyles.white16_400,
                        foucsedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        fillColor: appColors.grey,
                      ),
                      SizedBox(height: height * 0.02),
                      CustmTextFormField(
                        validation: (value){
                          if (value==null||value.length == 0) {
                            return 'Please enter mobile number';
                          }else if(!value.contains("+20")){
                            return "inValid phoneNumber";
                          }
                        },
                        controller: phoneController,
                        FilledTextStyle: AppStyles.white16_400,
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.phone_icon),
                          color: appColors.white,
                        ),
                        hintText: "phonnumber".tr(),
                        hintTextStyle: AppStyles.white16_400,
                        foucsedBorderColor: Colors.transparent,
                        enabledBorderColor: Colors.transparent,
                        fillColor: appColors.grey,
                      ),
                      SizedBox(height: height * 0.02),
                      Visibility(visible: error==0?false:true,
                          child: Text(registerViewModel.message??"",style: TextStyle(color: Colors.red,fontSize: 20),)),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: width * 0.9,
                        height: height * 0.055,
                        child: CustmElevatedButton(
                          onpressed: () {
                            if(formKey.currentState?.validate()==true){
                              registerViewModel.Registe(
                                  name: nameController.text,
                                  email: emailController.text,
                                  Password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                  phone: phoneController.text,
                                  context: context,
                                  avaterId: selectedAvatar);
                            }
                          },
                          text: "create_account".tr(),
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
                            "already_have_account".tr(),
                            style: AppStyles.white16_400,
                          ),
                          Customtextbutton(
                            onpressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginPage.loginroute,
                              );
                            },
                            text: "login",
                            style: AppStyles.primary20bold,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      AnimatedToggleSwitch<int>.rolling(
                        current: currentSelected,
                        values: [0,1],
                        iconList: [
                          CountryFlag.fromCountryCode('US',
                            shape: const Circle(),)
                          ,

                          CountryFlag.fromCountryCode(
                            'EG',
                            shape: const Circle(),)

                        ],
                        onChanged: (i) {
                          currentSelected = i;
                          currentSelected==0?provider.ChangeLanguage(context,"en"):provider.ChangeLanguage(context,"ar");
                          currentSelected==0?provider.WriteLocal("en"):provider.WriteLocal("ar");
                        } ,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );},

        listener:(context, state) {
            if (state is BacktoLoginState){
              Fluttertoast.showToast(
                  msg: "User Created Successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 20.0
              );
              ShowDialogUtils.HideLoading(context);
              Navigator.pop(context);

            }else if(state is RegisterErrorState){
              ShowDialogUtils.HideLoading(context);
              ShowDialogUtils.ShowMessage(context, Title: "Error",
                  PosActionName: "ok",
                  Content: registerViewModel.message
              );
            }
          },)
    );

  }
}
