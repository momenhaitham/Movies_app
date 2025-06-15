import 'package:flutter/material.dart';

import '../models/movies_response.dart';
import '../utils/app_styles.dart';

class FilmItemBuilder extends StatelessWidget {
  double? Width;
  Movies PassedMovie;
  FilmItemBuilder({required this.PassedMovie,this.Width});
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
        clipBehavior: Clip.antiAlias,
        width: Width ,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(child:Image.network(PassedMovie.mediumCoverImage!,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
              borderRadius: BorderRadius.circular(20),),
            Container(child: Row(
              children: [
                Text("${PassedMovie.rating}",style: AppStyles.regular20white,),
                Spacer(),
                Icon(Icons.star,color: Colors.amberAccent,)
              ],),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: Colors.black87),
              margin: EdgeInsets.only(top: 10,left: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: 82,
            )
          ],
        )
    );
  }
}
