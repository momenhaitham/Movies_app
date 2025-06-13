import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/custm_elevated_button.dart';
import 'package:movies_app/Reusable_widgets/film_item_builder.dart';
import 'package:movies_app/Tabs/home_tab/home_tab_states.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../models/movies_response.dart';
import '../../providers/app_provider.dart';
import 'home_tab_view_model.dart';

class HomeTab extends StatefulWidget{

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>{
  int selectedIndex = 0;
  var homeTabViewModel = HomeTabViewModel();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    int randomIndex = Random().nextInt(homeTabViewModel.genres.length);
    String randomGenra = homeTabViewModel.genres[randomIndex];
    homeTabViewModel.getAvailableMovies(randomGenra);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context)=>homeTabViewModel,
      child: BlocBuilder<HomeTabViewModel,HomeTabStates>(builder: (context, state) {
        if(state is HomeTabErrorState){
          return Center(child: Column(
            children: [
              Text(homeTabViewModel.message??"something went Wrong",style: AppStyles.bold36yellow,),
              CustmElevatedButton(onpressed: ()async{
                await provider.GetProfileData(provider.CurrentUserTokin!);
                setState(() {});
              },text: "try Again",styleOfChild: AppStyles.black16_400,BGcolor: Colors.amber,

              )
            ],
          ));
        }
        else if(state is HomeTabSuccessState){
          return SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.transparent,
                width: double.infinity,
                height: height*0.75,
                child: Stack(children: [
                  Image.asset(AppImages.intro1,fit: BoxFit.fitWidth,width: double.infinity,),
                  Image.asset(AppImages.intro1shade,fit: BoxFit.fitWidth,width: double.infinity,),
                  Column(children: [
                    SizedBox(height: height*0.04,),
                    Center(child: Image.asset(AppImages.AvailableNow)),
                    CarouselSlider(
                      options: CarouselOptions(
                        initialPage: selectedIndex,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        height: 400.0,
                        animateToClosest: true,
                        onPageChanged: (index, reason) {
                          selectedIndex=index;

                        },
                        enlargeCenterPage: true,
                      ),
                      items: homeTabViewModel.AvailableMovies!.map((i){
                        return Builder(
                          builder: (BuildContext context) {
                            return FilmItemBuilder(PassedMovie: i,Width: width*0.6,);
                          },
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    Center(child: Image.asset(AppImages.WatchNow)),
                  ],)
                ],),
              ),
              SizedBox(height: height*0.03,),
              Row(
                children: [Text(randomGenra,style: AppStyles.regular20white,),
                  Spacer(),
                  TextButton(
                    child: Row(
                      children: [
                        Text("See More",style: AppStyles.bold20yellow,),
                        Icon(Icons.arrow_forward,color: Colors.amber,),
                      ],
                    ),
                    onPressed: (){},),

                ],
              ),
              SizedBox(
                height: height*0.45,
                child: ListView.builder(itemBuilder: (context, index) {
                  return FilmItemBuilder(PassedMovie: homeTabViewModel.WatchNowMovies![index], Width: width*0.63,);
                },
                  itemCount:homeTabViewModel.WatchNowMovies!.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),);
        }else{
          return Center(child: CircularProgressIndicator(color: Colors.amber,));
        }
      },)
    );
  }
}
