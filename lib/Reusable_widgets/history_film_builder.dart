import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manager.dart';

import '../models/movie_details_response.dart';
import '../models/movies_response.dart';
import '../screens/Movie_Details_Screen/movie_details_screen.dart';
import '../utils/app_styles.dart';

class HistoryFilmBuilder extends StatefulWidget {
  double? Width;
  MovieDetailsResponse movieDetailsResponse;

  HistoryFilmBuilder({ this.Width,required this.movieDetailsResponse});

  @override
  State<HistoryFilmBuilder> createState() => _HistoryFilmBuilderState();
}

class _HistoryFilmBuilderState extends State<HistoryFilmBuilder> {

  @override

  int startPointFlag=0;
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ()async{
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,arguments: widget.movieDetailsResponse);
      },
      child: Container(
          clipBehavior: Clip.antiAlias,
          width: widget.Width ,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(child:Image.network(widget.movieDetailsResponse!.data!.movie!.mediumCoverImage!,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
                borderRadius: BorderRadius.circular(20),),
              Container(child: Row(
                children: [
                  Text("${widget.movieDetailsResponse!.data!.movie!.rating}",style: AppStyles.regular20white,),
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
      ),
    );
  }
}
