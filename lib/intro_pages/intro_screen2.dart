import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../utils/custm_elevated_button.dart';
import 'intro_screen3.dart';

class IntroScreen2 extends StatelessWidget{
  @override
  static String routeName = "intro2";
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.intro2,fit: BoxFit.fill,height: double.infinity,),
          Image.asset(AppImages.intro2shade,fit: BoxFit.fitHeight,height: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //height: height*0.3,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:Colors.black87 ),
                child: Column(
                  children: [
                    Center(child: Text("Discover Movies",style: AppStyles.normal36white,)),
                    SizedBox(height: height*0.02,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: Center(child: Text("Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
                        style: AppStyles.regular20white,)),
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
                      width: double.infinity,
                      height: height*0.07,
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: CustmElevatedButton(text:"Next",
                        BGcolor: Colors.amber,
                        styleOfChild: AppStyles.bold36black,
                        onpressed: (){Navigator.of(context).pushNamed(IntroScreen3.routeName);},),
                    ),
                    SizedBox(height: height*0.04,),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}