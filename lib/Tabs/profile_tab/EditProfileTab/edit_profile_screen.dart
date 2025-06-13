
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Reusable_widgets/custm_elevated_button.dart';
import 'package:movies_app/Tabs/profile_tab/EditProfileTab/reset_password_screen.dart';
import 'package:provider/provider.dart';

import '../../../Reusable_widgets/custm_text_form_field.dart';
import '../../../Reusable_widgets/show_dialog_utils.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import 'edit_profile_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "editProfile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController EmailEditControler = TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  EditProfileViewModel editProfileViewModel =EditProfileViewModel();
  int? selectedAvatar;
  int startPoint=0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    if(startPoint==0){
      selectedAvatar=provider.selectedAvatar;
      EmailEditControler.text=provider.ProfileData!.email!;
      nameController.text=provider.ProfileData!.name??"";
      phoneController.text=provider.ProfileData!.phone!;
      startPoint++;
    }
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create:(context)=>editProfileViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.black,
          title:Text("Pick Avatar",style: AppStyles.regular20white),
          centerTitle: true,
        ),
      backgroundColor: appColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: height*0.1,),
          Center(child: InkWell(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context) {
                  return Container(
                    color: appColors.Lightblack,
                    width: double.infinity,
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return InkWell(onTap: (){selectedAvatar=index;setState(() {});},
                          child: Container(margin: EdgeInsets.symmetric(horizontal:3,vertical: 3),
                            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(40),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.amber,width:1)
                            ),
                            child: Image.asset(provider.images[index]),
                          ),
                        ) ;
                      },itemCount: provider.images.length,),
                  );
                },);
              }, child: Image.asset(provider.images[selectedAvatar!])),),
          SizedBox(height: height*0.04,),
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
            controller: EmailEditControler,
            FilledTextStyle: AppStyles.white16_400,
            prefixIcon: ImageIcon(
              AssetImage(AppImages.email_icon),
              color: appColors.white,
            ),
            hintText: provider.ProfileData!.email!.tr(),
            hintTextStyle: AppStyles.white16_400,
            foucsedBorderColor: Colors.transparent,
            enabledBorderColor: Colors.transparent,
            fillColor: appColors.grey,
          ),
          SizedBox(height: height*0.02,),
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
          SizedBox(height: height*0.02,),
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
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
              }, child: Text("Reset Password",style: AppStyles.regular20white,)),
            ],
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: height*0.07,
            child: CustmElevatedButton(onpressed: (){},
              BGcolor: Colors.red,
              borderRadius: 10,
              text: "Delete Account",
              styleOfChild: AppStyles.black16_400,
            ),
          ),
          SizedBox(height: height*0.04,),
          Container(
            width: double.infinity,
            height: height*0.07,
            child: CustmElevatedButton(onpressed: ()async{
              await editProfileViewModel.UpdateProfile(context: context,tokin: provider.CurrentUserTokin!,
                  email:EmailEditControler.text,
                  newAvatar: selectedAvatar,
                  phone: phoneController.text,
                  name: nameController.text
              );
              provider.GetProfileData(provider.CurrentUserTokin!);
              setState(() {});
            },
              BGcolor: Colors.amber,
              borderRadius: 10,
              text: "Update Data",
              styleOfChild: AppStyles.black16_400,
            ),
          ),
          SizedBox(height: height*0.04,),
        ],
      ),),
    );
  }
}
