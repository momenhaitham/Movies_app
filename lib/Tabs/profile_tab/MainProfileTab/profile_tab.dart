import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/favorite_film_builder.dart';
import 'package:movies_app/Reusable_widgets/film_item_builder.dart';
import 'package:movies_app/Reusable_widgets/history_film_builder.dart';
import 'package:movies_app/Tabs/profile_tab/EditProfileTab/edit_profile_screen.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab_states.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab_view_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../Reusable_widgets/custm_elevated_button.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/login_screen/login_page.dart';

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
          if(provider.ProfileData==null||provider.favoriteMovies==null)
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
                            Text("${provider.favoriteMovies?.data?.length??"0"}",style:AppStyles.regular20white,),
                            SizedBox(height: height*0.03,),
                            Text("Wish List",style:AppStyles.regular20white,),
                          ],mainAxisAlignment: MainAxisAlignment.center,),
                          Column(children: [
                            Text("${provider.History.length}",style:AppStyles.regular20white,),
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
                          child: CustmElevatedButton(onpressed: (){
                            provider.History=[];
                            provider.favoriteMovies=null;
                            provider.HistoryMovies=[];
                            provider.CurrentUserTokin=null;
                            provider.ProfileData=null;
                            provider.selectedAvatar=null;
                            Navigator.popUntil(context, (route){return route.settings.name==LoginPage.loginroute;});
                            Navigator.pushNamed(context, LoginPage.loginroute);
                          },
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
                            onTap: ()async {
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
                ButtonBarindex==0?
                Expanded(child:provider.favoriteMovies==null?Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: Image.asset(AppImages.SearchEmpty),)],
                ):GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5),padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                    return FavoriteFilmBuilder(PassedMovie: provider.favoriteMovies!.data![index]);
                      //return FilmItemBuilder(PassedMovie:res);
                    },itemCount:provider.favoriteMovies?.data!.length,shrinkWrap: true,)):
                Expanded(child:provider.HistoryMovies.isEmpty?Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: Image.asset(AppImages.SearchEmpty),)],
                ): GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5),padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                      return HistoryFilmBuilder(movieDetailsResponse: provider.HistoryMovies[index],);
                    //return FilmItemBuilder(PassedMovie:res);
                  },itemCount:provider.History.length,shrinkWrap: true,))
              ],
            );
          }
        },
        listener: (context, state) {
        },
      ),
    );
  }
}
