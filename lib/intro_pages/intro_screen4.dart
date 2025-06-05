import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/intro_pages/intro_screen5.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../utils/custm_elevated_button.dart';

class IntroScreen4 extends StatelessWidget{
  @override
  static String routeName = "intro4";
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.intro4,fit: BoxFit.fill,height: double.infinity,),
          Image.asset(AppImages.intro4shade,fit: BoxFit.fitHeight,height: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //height: height*0.3,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:Colors.black87 ),
                child: Column(
                  children: [
                    Center(child: Text("Create Watchlists",style: AppStyles.normal36white,)),
                    SizedBox(height: height*0.02,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: Center(child: Text("Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
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
                        onpressed: (){Navigator.of(context).pushNamed(IntroScreen5.routeName);},),
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