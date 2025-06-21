import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';

import '../../models/favorite_movies_response.dart';
import '../../models/movies_response.dart';
import 'home_tab_states.dart';

class HomeTabViewModel extends Cubit<HomeTabStates>{
  List<Movies>? AvailableMovies;
  List<Movies>? WatchNowMovies;
  String? message;
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

  HomeTabViewModel():super(HomeTabLoadingState());

  void getAvailableMovies(String Genra)async{
    emit(HomeTabLoadingState());
    try{
      var response = await apiManager.getMovies();
      var response2 = await apiManager.getMovies(Genra: Genra);

      if(response.status=='error'){
        emit(HomeTabErrorState());
        message = response.statusMessage;
      }else if(response.status=='ok'){
        emit(HomeTabSuccessState());
        AvailableMovies=response.data?.movies;
        WatchNowMovies=response2.data?.movies;
      }
    }catch(e){
      emit(HomeTabErrorState());
      message = e.toString();
      print(message);
    }
  }



}