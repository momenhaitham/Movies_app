import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/custm_text_form_field.dart';
import 'package:movies_app/Reusable_widgets/film_item_builder.dart';
import 'package:movies_app/Tabs/search_tab/search_tab_states.dart';
import 'package:movies_app/Tabs/search_tab/search_tab_view_model.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  SearchTabViewModel searchTabViewModel=SearchTabViewModel();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: height*0.06,),
        BlocProvider(create: (context)=>searchTabViewModel,
        child: BlocConsumer<SearchTabViewModel,SearchTabStates>(
            builder:(context, state) {
              return CustmTextFormField(
                cursorColor: Colors.amber,
                enabledBorderColor: Colors.amber,
                foucsedBorderColor: Colors.amber,
                FilledTextStyle: AppStyles.bold20yellow,
                prefixIcon: Icon(Icons.search_rounded,color: Colors.amber,),
                hintText:"Search for a Movie",
                hintTextStyle: AppStyles.bold20yellow,
                OnChanged: (text)async{
                  searchTabViewModel.searchController=text;
                  searchTabViewModel.GetMoviesBySearch(searchTabViewModel.searchController??"");

                  searchTabViewModel.EnterLoadingState();
                },
              );
            } ,
            listener: (context, state){


            },),
        ),
        Expanded(
          child: BlocProvider(create: (context)=>searchTabViewModel,
            child: BlocConsumer<SearchTabViewModel,SearchTabStates>(
              builder:(context, state) {
                if(state is SearchTabState){
                  return Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Image.asset(AppImages.SearchEmpty),)],
                  ));
                }else if(state is SearchTabLoadingState){
                  return Expanded(child: Column(
                    children: [Center(child: CircularProgressIndicator(color: Colors.amber,))],
                  ));
                }else if(state is SearchTabSuccessState){
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: width*0.02,
                  mainAxisSpacing: height*0.02
                  ),
                    itemBuilder: (context, index) {
                      return FilmItemBuilder(PassedMovie: searchTabViewModel.MoviesBySearch![index]);
                    },itemCount:searchTabViewModel.MoviesBySearch!.length ,);
                }else{
                  return Container();
                }
              } ,
              listener: (context, state) {
                if(state is SearchTabState){

                }
              },),
          ),
        )

      ],
    );
  }
}
