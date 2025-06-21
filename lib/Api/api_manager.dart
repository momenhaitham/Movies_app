
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Reusable_widgets/show_dialog_utils.dart';
import 'package:movies_app/models/add_movie_to_favorit_response.dart';
import 'package:movies_app/models/delete_from_favorite_response.dart';
import 'package:movies_app/models/favorite_movies_response.dart';
import 'package:movies_app/models/get_profile_response.dart';
import 'package:movies_app/models/is_favorite_response.dart';
import 'package:movies_app/models/login_response.dart';
import 'package:movies_app/models/movie_details_response.dart';
import 'package:movies_app/models/movies_response.dart';
import 'package:movies_app/models/register_response.dart';
import 'package:movies_app/models/reset_password_response.dart';
import 'package:movies_app/models/update_profile_response.dart';
import '../models/movies_response.dart';
import 'api_constants.dart';
import 'end_points.dart';

class ApiManager {
  Future<MoviesResponse> getMovies({String? Genra,String? Search})async{
    try{
      Uri url = Uri.https('yts.mx','/api/v2/list_movies.json',{
        "genre":Genra,
        "query_term":Search
      });
      var response=await http.get(url);
      var json = jsonDecode(response.body);
      print(json);
      var res= MoviesResponse.fromJson(json);
      print("AAAAAA");
      return res;
    }catch(e){
      print("Niiggggggggggggggggggg");
      print(e);
      throw e ;

    }
  }

  static Future<MovieDetailsResponse> GetMovieDetails({required double MovieID})async{
    try{
      Uri url = Uri.https('yts.mx','/api/v2/movie_details.json',{
        "movie_id":MovieID.toInt().toString(),
        "with_images":true.toString(),
        "with_cast":true.toString()
      });
      var response=await http.get(url);
      var json = jsonDecode(response.body);
      print(json);
      var res= MovieDetailsResponse.fromJson(json);
      print("AAAAAA");
      return res;
    }catch(e){
      print("Niiggggggggggggggggggg");
      print(e);
      throw e ;
    }
  }

  static Future<FavoriteMoviesResponse> GetFavoriteMovies({required String tokin})async{
    try{
      Uri url = Uri.https('route-movie-apis.vercel.app','/favorites/all');
      var response=await http.get(url,headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokin',
      });
      var json = jsonDecode(response.body);
      print(json);
      var res= FavoriteMoviesResponse.fromJson(json);
      return res;
    }catch(e){
      print(e);
      throw e ;
    }
  }

  static Future<MoviesResponse> GetMovieSuggestions({required double MovieID})async{
    try{
      Uri url = Uri.https('yts.mx','/api/v2/movie_suggestions.json',{
        "movie_id":MovieID.toInt().toString(),
      });
      var response=await http.get(url);
      var json = jsonDecode(response.body);
      print(json);
      var res= MoviesResponse.fromJson(json);
      print("AAAAAA");
      return res;
    }catch(e){
      print("Niiggggggggggggggggggg");
      print(e);
      throw e ;
    }
  }

  static Future<AddMovieToFavoritResponse> AddMovieToFavorit({
    required String tokin,
    required int MovieID,
    required String name,
    required double rateing,
    required String imageURL,
    required String year}
  )async
  {

      Uri url = await Uri.https('route-movie-apis.vercel.app','favorites/add');
      var requist =await http.post(url,
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokin'
        },
        body:jsonEncode({
          "movieId": MovieID.toString(),
          "name": name,
          "rating": rateing,
          "imageURL": imageURL,
          "year": year
        })
      );
     var json = jsonDecode(requist.body);
     print(json);
     var response = AddMovieToFavoritResponse.fromJson(json);
     return response;



    //Success Login
  }

  static Future<DeleteFromFavoriteResponse> DeleteMovieFromFavorite({required String tokin, required int MovieID,})async{
    Uri url = await Uri.https('route-movie-apis.vercel.app','favorites/remove/${MovieID}');
    var requist =await http.delete(url,
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokin',
      },
    );
    var json = jsonDecode(requist.body);
    print(json);
    return DeleteFromFavoriteResponse.fromJson(json);
  }

  static Future<IsFavoriteResponse> IsFavorite({required String tokin,required int MovieID,})async{
    try{
      Uri url = await Uri.https('route-movie-apis.vercel.app','favorites/is-favorite/${MovieID}',
      //{
      //  'movieId':MovieID.toString()
      //}
      );
      var requist =await http.get(url,
          headers: {'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokin',
          },
      );
      var json = jsonDecode(requist.body);
      print(json);
      var response = IsFavoriteResponse.fromJson(json);
      return response;
    }catch(e){
      throw e;
    }
  }

  static Future<LoginResponse> Login({required String Email,required String Password})async{
    try{Uri url = await Uri.https('route-movie-apis.vercel.app','/auth/login');
    var requist =await http.post(url,
        headers: {'Content-Type': 'application/json',},
        body:jsonEncode({
          "email":Email,
          "password":Password})
    );
    var json = jsonDecode(requist.body);
    print(json);
    var response = LoginResponse.fromJson(json);
    return response;}catch(e){
      throw e;
    }

    //Success Login
  }

  static Future<RegisterResponse> Register({
    required String name,
    required String email,
    required String Password,
    required String confirmPassword,
    required String phone,
    required int avaterId,

  })async
  {
    try{
      Uri url = await Uri.https('route-movie-apis.vercel.app','/auth/register');
      var requist =await http.post(url,
          headers: {'Content-Type': 'application/json',},
          body:jsonEncode({
            "name":name,
            "email":email,
            "password":Password,
            "confirmPassword":confirmPassword,
            "phone":phone,
            "avaterId":avaterId})
      );
      var json = jsonDecode(requist.body);
      print(json);
      var response = RegisterResponse.fromJson(json);
      return response;
    }catch(e){
      throw e;
    }

  }

  static Future<ResetPasswordResponse> ResetPassword({required String tokin,required String oldPassword,required String newPassword})async{

    try{Uri url = await Uri.https('route-movie-apis.vercel.app','/auth/reset-password');
    var requist =await http.patch(url,
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokin',
        },
        body:jsonEncode({
          "oldPassword":oldPassword,
          "newPassword":newPassword})
    );
    var json = jsonDecode(requist.body);
    print(json);
    var response = ResetPasswordResponse.fromJson(json);
    return response;}catch(e){
      throw e;
    }

  }

  static Future<UpdateProfileResponse> UpdateProfile({required String tokin,String? email,int? avaterId,String? name, String? phone })async{
    try{
      Uri url = await Uri.https('route-movie-apis.vercel.app','/profile');
      var requist =await http.patch(url,
          headers: {'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokin',
          },
          body:jsonEncode({
            "email":email,
            "avaterId":avaterId,
            "name":name,
            "phone ":phone
          })
      );
      var json = jsonDecode(requist.body);
      print(json);
      var response = UpdateProfileResponse.fromJson(json);
      return response;
    }catch(e){
      throw e;
    }
  }

  static Future<GetProfileResponse> GetProfile ({required String tokin})async{
    Uri url = await Uri.https('route-movie-apis.vercel.app','/profile');
    var requist =await http.get(url,
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokin'},
    );
    var json = jsonDecode(requist.body);
    print(json);
    return GetProfileResponse.fromJson(json);
  }

}
//