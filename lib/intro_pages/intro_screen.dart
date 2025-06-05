import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../utils/custm_elevated_button.dart';

class IntroScreen extends StatelessWidget{
  @override
  static String routeName = "intro";
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.intro1,fit: BoxFit.fill,),
          Image.asset(AppImages.intro1shade,fit: BoxFit.fill,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text("Find Your Next",style: AppStyles.normal36white,)),
              Center(child: Text("Favorite Movie Here",style: AppStyles.normal36white,)),
              SizedBox(height: height*0.02,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.03),
                child: Center(child: Text("Get access to a huge library of movies to suit all tastes. You will surely like it.",
                  style: AppStyles.regular20white,)),
              ),
              SizedBox(height: height*0.02,),
              Container(
                height: height*0.08,
                margin: EdgeInsets.symmetric(horizontal: width*0.03),
                child: CustmElevatedButton(text:"Explore Now",
                  BGcolor: Colors.amber,
                  styleOfChild: AppStyles.bold36black,
                  onpressed: (){},),
              ),
              SizedBox(height: height*0.04,),
            ]
          )
        ],
      ),
    );
  }
}