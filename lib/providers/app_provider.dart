import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/models/favorite_movies_response.dart';
import 'package:movies_app/models/get_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_details_response.dart';
import '../utils/app_images.dart';
import '../utils/shared_prefs.dart';

class AppProvider extends ChangeNotifier {

  String? CurrentLocal;
  String? CurrentUserTokin;
  List images = [
    AppImages.gamer1,
    AppImages.gamer2,
    AppImages.gamer3,
    AppImages.gamer4,
    AppImages.gamer5,
    AppImages.gamer6,
    AppImages.gamer7,
    AppImages.gamer8,
    AppImages.gamer9,];
  Data? ProfileData;
  FavoriteMoviesResponse? favoriteMovies;
  int? selectedAvatar;
  List<String>History=[];
  List<MovieDetailsResponse> HistoryMovies=[];

//==============================================================================
  void ReadTokin() async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    CurrentUserTokin = share.getString(sharedPrefs.UserTokin)??null;
    notifyListeners();
  }

  void WriteTokin(String tokin)async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    await share.setString(sharedPrefs.UserTokin, tokin);
    notifyListeners();
  }

  Future<void> GetProfileData(String Tokin)async{

   var response = await ApiManager.GetProfile(tokin: Tokin);
   ProfileData = response.data;
   selectedAvatar = ProfileData?.avaterId??0;
   notifyListeners();
  }

  //============================================================================
  void ReadLocal() async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    CurrentLocal = share.getString(sharedPrefs.LocalePref)??"en";
    notifyListeners();
  }

  void WriteLocal(String newlocal)async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    await share.setString(sharedPrefs.LocalePref, newlocal);
  }

  void ChangeLanguage(BuildContext context, String newlocal)
  {
    if(CurrentLocal==newlocal)
    {
      return;
    }
    CurrentLocal=newlocal;
    context.setLocale(Locale(newlocal));
    notifyListeners();
  }
//==============================================================================
  Future<void> getFavoriteMovies({required String tokin})async{
    var res = await ApiManager.GetFavoriteMovies(tokin: tokin);
    favoriteMovies = res;
  }

  void DeletMovieFromFavorite({required int MovieID})async{
    favoriteMovies!.data!.removeWhere((s){
      if(s.movieId==MovieID){
        return true;
      }else{
        return false;
      }
    });
    await getFavoriteMovies(tokin: CurrentUserTokin!);
    notifyListeners();
  }

  void AddMovieToFavorite({
    required int MovieID,
    required String name,
    required double rateing,
    required String imageURL,
    required String year})async
  {
    favoriteMovies!.data!.add(DataF(imageURL: imageURL,name: name,movieId: MovieID.toString(),rating: rateing));
    await getFavoriteMovies(tokin: CurrentUserTokin!);
    notifyListeners();
  }
//==============================================================================
  Future<void> ReadHistory() async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    History =await share.getStringList(sharedPrefs.History)??[];
    for(int i = 0 ; i<=History.length;i++){
      MovieDetailsResponse movieDetailsResponse =await ApiManager.GetMovieDetails(MovieID:double.parse(History[i]));
      HistoryMovies.add(movieDetailsResponse);
    }
    notifyListeners();
  }

  void WriteHistory(String MovieID)async
  {

    //History.removeWhere((id){
    //  if(id==MovieID){return true;}else return false;
    //});
    History.remove(MovieID);
    notifyListeners();
    History.add(MovieID);
    SharedPreferences share= await SharedPreferences.getInstance();
    share.setStringList(sharedPrefs.History, History);
    MovieDetailsResponse movieDetailsResponse =await ApiManager.GetMovieDetails(MovieID:double.parse(MovieID));
    HistoryMovies.add(movieDetailsResponse);
    notifyListeners();
  }
}
