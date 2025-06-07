import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../Reusable_widgets/custm_elevated_button.dart';
import 'intro_screen6.dart';

class IntroScreen5 extends StatelessWidget{
  @override
  static String routeName = "intro5";
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.intro5,fit: BoxFit.fill,height: double.infinity,),
          Image.asset(AppImages.intro5shade,fit: BoxFit.fitHeight,height: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //height: height*0.3,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:Colors.black87 ),
                child: Column(
                  children: [
                    Center(child: Text("Rate, Review, and Learn",style: AppStyles.normal36white,)),
                    SizedBox(height: height*0.02,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      child: Center(child: Text("Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
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
                        onpressed: (){Navigator.of(context).pushNamed(IntroScreen6.routeName);},),
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