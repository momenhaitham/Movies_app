import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/screens/Movie_Details_Screen/movie_details_states.dart';

import '../../models/movie_details_response.dart';
import '../../models/movies_response.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates>{
  MovieDetailsViewModel():super(MovieDetailsState());
  MovieDetailsResponse? movieDetailsResponse;
  MoviesResponse? movieSuggestions;
  bool? isFavorite;
  void GetMovieSuggestions()async{
    emit(MovieDetailsLoadingState());
    var response =await ApiManager.GetMovieSuggestions(MovieID: movieDetailsResponse!.data!.movie!.id!.toDouble());
    movieSuggestions = response;

  }

  Future<void> AddToFavorit({ required String tokin,
    required int MovieID,
    required String name,
    required double rateing,
    required String imageURL,
    required String year}) async
  {
    await ApiManager.AddMovieToFavorit(tokin: tokin, MovieID: MovieID, name: name, rateing: rateing, imageURL: imageURL, year: year);
      emit(MovieAddedToFavoritSuccessState());

  }

  void DeleteFromFavorite({required String tokin, required int MovieID,})async{
    await ApiManager.DeleteMovieFromFavorite(tokin: tokin, MovieID: MovieID);
      emit(MovieDeletedFromFavoritSuccessState());
  }


  void IsFavorite({required String tokin,required int MovieID,})async{
    var res =await ApiManager.IsFavorite(tokin: tokin, MovieID: MovieID);
    isFavorite=res.data;
    if(isFavorite!=null){
      emit(MovieDetailsSuccessState());
    }
  }

}