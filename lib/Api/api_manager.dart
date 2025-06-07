
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movies_response.dart';
import '../models/movies_response.dart';
import 'api_constants.dart';
import 'end_points.dart';

class ApiManager {
  Future<MoviesResponse> getMovies({String? Genra})async{
    try{
      Uri url = Uri.https('yts.mx','/api/v2/list_movies.json',{
        "genre":Genra
      });
      var response=await http.get(url);
      var json = jsonDecode(response.body);
      print(json);
      var res= MoviesResponse.fromJson(json);
      print("AAAAAA");
      return res;
    }catch(e) {
      print("Niiggggggggggggggggggg");
      print(e);
      throw e ;

    }
  }
}