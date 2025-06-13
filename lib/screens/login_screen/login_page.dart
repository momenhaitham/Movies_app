import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/show_dialog_utils.dart';
import 'package:movies_app/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/screens/forgotpassword.dart';
import 'package:movies_app/screens/login_screen/login_page_states.dart';
import 'package:movies_app/screens/login_screen/login_page_view_model.dart';
import 'package:movies_app/screens/register_screen/regstier.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import 'package:movies_app/Reusable_widgets/customTexButton.dart';

import 'package:movies_app/Reusable_widgets/customswitch.dart';
import 'package:provider/provider.dart';

import '../../Reusable_widgets/custm_elevated_button.dart';
import '../../Reusable_widgets/custm_text_form_field.dart';
import '../../providers/app_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static const String loginroute = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentSelected = 0;

  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var log = LoginPageViewModel();

  int error=0;
  @override
  Widget build(BuildContext context) {

    var widht = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    currentSelected =provider.CurrentLocal=="en"? 0:1;
    return BlocProvider(
      create: (context) => log,
      child:BlocConsumer<LoginPageViewModel,LoginPageStates>(
          builder:(context, state) {
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
                            fillColor: appColors.grey,
                            foucsedBorderColor: Colors.transparent,
                            enabledBorderColor: Colors.transparent,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: Customtextbutton(
                              onpressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ForgotPassWord.forgotPasswordRoute,
                                );
                              },
                              text: "forgot_password".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: appColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          SizedBox(height: height * 0.02),
                          Container(
                            width: widht * 0.9,
                            height: height * 0.055,
                            child: CustmElevatedButton(
                              onpressed: ()async{
                                if(formKey.currentState?.validate()==true){
                                  final bool isConnected = await InternetConnectionChecker.instance.hasConnection;
                                  if (isConnected){
                                    ShowDialogUtils.ShowLoading(context);
                                    log.Login(Email: emailController.text, Password: passwordController.text,context: context);
                                  }else{
                                    ShowDialogUtils.ShowMessage(context, Title: "Error",
                                    Content: "No InterNet Connection",
                                    NigActionName: "Ok",
                                    NigAction: (){Navigator.pop(context);});
                                  }

                                  //showDialog(context: context, builder:(context) =>AlertDialog(
                                  //  title: Text("Loading"),content: CircularProgressIndicator(),
                                  //),barrierDismissible: false);
                                }
                              },
                              text: "login".tr(),
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
                                "dont_have_account".tr(),
                                style: AppStyles.white16_400,
                              ),
                              Customtextbutton(
                                onpressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Regstier_page.regstierroute,
                                  );
                                },
                                text: "create_account".tr(),
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
                                "or".tr(),
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
                              onPressed: () {

                              },
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
                                    "loginwith_google".tr(),
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
                          AnimatedToggleSwitch<int>.rolling(
                            current: currentSelected,
                            values: [0,1],
                            iconList: [
                              CountryFlag.fromCountryCode('ES',
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
              );
          } ,
          listener: (context, state) {
            if (state is GoToHomeState){
              provider.WriteTokin(log.tokin!);
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            }else if(state is LoginErrorState){
              ShowDialogUtils.HideLoading(context);
              ShowDialogUtils.ShowMessage(context, Title: "Error",
              PosActionName: "ok",
                Content: log.message
              );
            }
          },)
    );
  }
}
/*

 */
