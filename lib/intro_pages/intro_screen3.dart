import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/intro_pages/intro_screen4.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../Reusable_widgets/custm_elevated_button.dart';

class IntroScreen3 extends StatelessWidget{
  @override
  static String routeName = "intro3";
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.intro3,fit: BoxFit.fill,height: double.infinity,),
          Image.asset(AppImages.intro3shade,fit: BoxFit.fitHeight,height: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //height: height*0.3,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:Colors.black87 ),
                child: Column(
                  children: [
                    Center(child: Text("Explore All Genres",style: AppStyles.normal36white,)),
                    SizedBox(height: height*0.02,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: Center(child: Text("Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
                        style: AppStyles.regular20white,)),
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                      width: double.infinity,
                      height: height*0.05,
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: CustmElevatedButton(text:"Next",
                        BGcolor: Colors.amber,
                        styleOfChild: AppStyles.bold36black,
                        onpressed: (){Navigator.of(context).pushNamed(IntroScreen4.routeName);},),
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                      width: double.infinity,
                      height: height*0.05,
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: CustmElevatedButton(text:"Back",
                        BGcolor: Colors.black87,
                        BorderWidth: 2,
                        BorderColor: Colors.amber,
                        styleOfChild: AppStyles.bold36yellow,
                        onpressed: (){Navigator.pop(context);},),
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