
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/custm_elevated_button.dart';
import 'package:movies_app/Tabs/profile_tab/EditProfileTab/reset_password_view_model.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../Reusable_widgets/custm_text_form_field.dart';
import '../../../Reusable_widgets/show_dialog_utils.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import 'edit_profile_view_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = "editPassword";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController NewPasswordController=TextEditingController();
  var resetPasswordViewModel=ResetPasswordViewModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) =>resetPasswordViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.black,
          title:Text("Reset PassWord",style: AppStyles.regular20white),
          centerTitle: true,
        ),
        backgroundColor: appColors.black,
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: height*0.04,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("old Password",style: AppStyles.regular20white,),
                ],
              ),
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
                controller: oldPasswordController,
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
              SizedBox(height: height*0.02,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("New Password",style: AppStyles.regular20white,),
                ],
              ),
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
                controller: NewPasswordController,
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
              Spacer(),
              SizedBox(height: height*0.04,),
              Container(
                width: double.infinity,
                height: height*0.07,
                child: CustmElevatedButton(onpressed: ()async{
                  if(formKey.currentState?.validate()==true)
                    {
                      ShowDialogUtils.ShowLoading(context);
                      final bool isConnected = await InternetConnectionChecker.instance.hasConnection;
                      if (isConnected){
                        await resetPasswordViewModel.ResetPassword(context: context,tokin: provider.CurrentUserTokin!,
                            oldPassword: oldPasswordController.text, newPassword: NewPasswordController.text);
                        ShowDialogUtils.HideLoading(context);
                        if(resetPasswordViewModel.message=="Password updated successfully"){
                          ShowDialogUtils.ShowMessage(context, Title: "Success",
                              Content: resetPasswordViewModel.message,
                              NigActionName: "Ok");
                          provider.GetProfileData(provider.CurrentUserTokin!);
                        }else if (resetPasswordViewModel.message==null){
                          ShowDialogUtils.ShowMessage(context, Title: "Error",
                              Content:"Some thing went Wrong",
                              NigActionName: "Ok"
                          );
                        }else{
                          ShowDialogUtils.ShowMessage(context, Title: "Error",
                              Content: resetPasswordViewModel.message,
                              NigActionName: "Ok"
                          );
                        }
                      }else{
                        ShowDialogUtils.ShowMessage(context, Title: "Error",
                            Content: "No InterNet Connection",
                            NigActionName: "Ok",
                          NigAction: (){Navigator.pop(context);}
                        );
                      }

                    }
                },
                  BGcolor: Colors.amber,
                  borderRadius: 10,
                  text: "Reset PassWord",
                  styleOfChild: AppStyles.black16_400,
                ),
              ),
              SizedBox(height: height*0.04,),
            ],
          ),
        ),),
    );
  }
}
