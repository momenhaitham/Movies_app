import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manager.dart';

import '../models/favorite_movies_response.dart';
import '../models/movie_details_response.dart' hide Data;
import '../models/movies_response.dart' hide Data;
import '../screens/Movie_Details_Screen/movie_details_screen.dart';
import '../utils/app_styles.dart';

class FavoriteFilmBuilder extends StatelessWidget {
  double? Width;
  DataF PassedMovie;
  FavoriteFilmBuilder({required this.PassedMovie,this.Width});
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: ()async{
        var MovieDetailsResponse = await ApiManager.GetMovieDetails(MovieID:double.parse(PassedMovie.movieId!) );
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,arguments: MovieDetailsResponse);
      },
      child: Container(
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
              ClipRRect(child:Image.network(PassedMovie.imageURL!,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
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
      ),
    );
  }
}
