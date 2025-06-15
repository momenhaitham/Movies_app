import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Reusable_widgets/film_item_builder.dart';
import 'package:movies_app/Tabs/browse_tab/browse_tab_states.dart';
import 'package:movies_app/Tabs/browse_tab/browse_tab_view_model.dart';
import 'package:movies_app/utils/app_styles.dart';

import 'browse_tabs_builder.dart';

class BrowseTab extends StatefulWidget {

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
   BrowseTabViewModel browseTabViewModel = BrowseTabViewModel();

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height*0.06,),
        BlocProvider(create:(context) =>  browseTabViewModel,
        child: BlocConsumer<BrowseTabViewModel,BrowseTabStates>(
            builder: (context, state) {
              return DefaultTabController(length:  browseTabViewModel.genres.length,
                  child: TabBar(
                    tabs:browseTabViewModel.genres.map((s)=>BrowseTabsBuilder(
                      BGColor: browseTabViewModel.selectedIndex==browseTabViewModel.genres.indexOf(s)?Colors.amber:Colors.black,
                      isSelected:browseTabViewModel.selectedIndex==browseTabViewModel.genres.indexOf(s)?true:false,
                      txt:s,
                      txtStyle:browseTabViewModel.selectedIndex==browseTabViewModel.genres.indexOf(s)?AppStyles.bold25black:AppStyles.bold20yellow,
                    )
                    ).toList(),
                    labelPadding: EdgeInsets.symmetric(horizontal: width*0.02),
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.transparent,
                    onTap: (index){browseTabViewModel.selectedIndex=index;
                      browseTabViewModel.EnterLoadingState();
                    setState(() {print("PRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");});
                    },
                    //labelColor: Colors.black,
                  )
              );
            },
            listener: (context, state) {

            },),
        ),
        BlocProvider(create: (context) => browseTabViewModel,
        child: BlocConsumer<BrowseTabViewModel,BrowseTabStates>(
            builder: (context, state) {
              browseTabViewModel.GetMoviesByGenra(Genra: browseTabViewModel.genres[browseTabViewModel.selectedIndex]);
              if(state is BrowseTabLoadingState){
                return Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator(color: Colors.amber,),),
                    ],
                  ),
                );
              }else{
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: width*0.02,
                      mainAxisSpacing: height*0.02,
                      crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return FilmItemBuilder(
                        PassedMovie: browseTabViewModel.MoviesByGenra![index],
                        Width: width * width*0.2,);
                    }, itemCount: browseTabViewModel.MoviesByGenra!.length,),
                );
              }

            },
            listener: (context, state) {

            },),
        )

      ],
    );
  }
}
