import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Tabs/profile_tab/EditProfileTab/edit_profile_screen.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab_states.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab_view_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../Reusable_widgets/custm_elevated_button.dart';
import '../../../providers/app_provider.dart';

class ProfileTab extends StatefulWidget {

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override

  int ButtonBarindex = 0;
  ProfileTabViewModel profileTabViewModel = ProfileTabViewModel();

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    print(provider.CurrentUserTokin);
    return BlocProvider(
      create: (context) => profileTabViewModel,
      child: BlocConsumer<ProfileTabViewModel,ProfileTabStates>(
        builder: (context, state) {

          if(provider.ProfileData==null)
            {

              return Center(child: CircularProgressIndicator(color: Colors.amber,),);
            }else{
            return Column(
              children: [
                Container(width: double.infinity,
                  height: height*0.45,
                  color: appColors.Lightblack,
                  child: Column(
                    children: [
                      SizedBox(height: height*0.044,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width: double.infinity,
                        height: height*0.25,
                        child: Row(children: [
                          Column(children: [
                            Image.asset(provider.images[provider.selectedAvatar!]),
                            SizedBox(height: height*0.01,),
                            Text(provider.ProfileData?.name??"error",style:AppStyles.regular20white,),
                          ],mainAxisAlignment: MainAxisAlignment.center,),
                          Column(children: [
                            Text("12",style:AppStyles.regular20white,),
                            SizedBox(height: height*0.03,),
                            Text("Wish List",style:AppStyles.regular20white,),
                          ],mainAxisAlignment: MainAxisAlignment.center,),
                          Column(children: [
                            Text("10",style:AppStyles.regular20white,),
                            SizedBox(height: height*0.03,),
                            Text("History",style:AppStyles.regular20white,),
                          ],mainAxisAlignment: MainAxisAlignment.center,),
                        ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                      ),
                      Row(children: [
                        Container(
                          child: CustmElevatedButton(onpressed: (){
                            Navigator.of(context).pushNamed(EditProfileScreen.routeName);
                          },
                            text: "Edit Profile",
                            borderRadius: 10,
                            BGcolor: Colors.amber,
                            styleOfChild:AppStyles.black16_400,
                          ),
                          width: width*0.5,
                        ),
                        SizedBox(width: width*0.02,),
                        Container(
                          child: CustmElevatedButton(onpressed: (){},
                            text: "Exit",
                            borderRadius: 10,
                            BGcolor: Colors.red,
                            styleOfChild:AppStyles.black16_400,
                          ),
                          width: width*0.25,
                        )
                      ],mainAxisAlignment: MainAxisAlignment.center,),
                      Spacer(),
                      AnimatedButtonBar(
                        children: [
                          ButtonBarEntry(
                            onTap: () {
                              ButtonBarindex = 0;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Icon(Icons.list,color: Colors.amber,),
                                Text("Watch List",style: AppStyles.bold20yellow,),
                              ],
                            ),
                          ),
                          ButtonBarEntry(
                            onTap: () {
                              ButtonBarindex = 1;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Icon(Icons.folder,color: Colors.amber,),
                                Text("History",style: AppStyles.bold20yellow,),
                              ],
                            ),
                          ),
                        ],
                        backgroundColor: appColors.Lightblack,
                        foregroundColor: Colors.amber,
                        invertedSelection: true,
                        borderWidth: 12,
                        radius: 12,
                      ),
                    ],
                  ),
                ),

              ],
            );
          }
        },
        listener: (context, state) {
          if(state is ProfileTabState){

          }
        },
      ),
    );
  }
}
