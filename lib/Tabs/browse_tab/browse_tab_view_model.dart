import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';

import '../../models/movies_response.dart';
import 'browse_tab_states.dart';

class BrowseTabViewModel extends Cubit<BrowseTabStates>{
  BrowseTabViewModel():super(BrowseTabLoadingState());
  ApiManager apiManager=ApiManager();
  List<String>genres=[
    'Animation',
    'Adventure',
    'Action',
    'Anime',
    'Comedy',
    'Documentary',
    'Crime',
    'Drama',
    'Family',
    'Fantasy',
    'Game Show',
    'Horror',
    'Lifestyle',
    'Sport',
  ];
  int selectedIndex = 0;
  List<Movies>? MoviesByGenra;

  void GetMoviesByGenra({required String Genra})async{
    var response = await apiManager.getMovies(Genra: Genra);
    MoviesByGenra = response.data!.movies;
    if(MoviesByGenra!=null){
      emit(BrowseTabSuccessState());
    }
  }
  void EnterLoadingState(){
    emit(BrowseTabLoadingState());
  }

}