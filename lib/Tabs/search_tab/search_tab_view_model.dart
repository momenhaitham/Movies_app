import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Tabs/search_tab/search_tab_states.dart';

import '../../models/movies_response.dart';

class SearchTabViewModel extends Cubit<SearchTabStates>{
  ApiManager apiManager = ApiManager();
  SearchTabViewModel():super(SearchTabState());
  List<Movies>? MoviesBySearch;
  String? searchController;
  String? ErrorMessage;

  Future<void> GetMoviesBySearch(String Search)async{
    var response = await apiManager.getMovies(Search: Search);
    MoviesBySearch = await response.data!.movies;
    if(MoviesBySearch==null||MoviesBySearch!.isEmpty){
      emit(SearchTabErrorState());
      ErrorMessage=response.statusMessage;
    }else
    EnterSuccessState();
  }

  void EnterLoadingState(){
    emit(SearchTabLoadingState());
  }

  void EnterSuccessState(){
    emit(SearchTabSuccessState());
  }

  void EnterDefulltState(){
    emit(SearchTabState());
  }
  
  

}