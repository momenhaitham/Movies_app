import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/custm_elevated_button.dart';
import 'package:movies_app/Reusable_widgets/film_item_builder.dart';
import 'package:movies_app/screens/Movie_Details_Screen/movie_details_states.dart';
import 'package:movies_app/screens/Movie_Details_Screen/movie_details_view_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_icons.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Reusable_widgets/show_dialog_utils.dart';
import '../../models/movie_details_response.dart';
import '../../providers/app_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  static String routeName = "MovieDetails";

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsViewModel movieDetailsViewModel = MovieDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState

  }
  int startingPoint = 0;

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    var PassedMovieDetails = ModalRoute.of(context)?.settings.arguments as MovieDetailsResponse;
    movieDetailsViewModel.movieDetailsResponse=PassedMovieDetails;
    movieDetailsViewModel.GetMovieSuggestions();
    movieDetailsViewModel.IsFavorite(tokin: provider.CurrentUserTokin!,
        MovieID: movieDetailsViewModel.movieDetailsResponse!.data!.movie!.id!);
    if(startingPoint<=1){
      provider.WriteHistory(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.id.toString());
      startingPoint++;
    }
    return Scaffold(
      backgroundColor: appColors.black,
      body:Stack(
        children: [
          ListView.builder(itemBuilder: (context, index) {

            return BlocProvider(create:(context)=> movieDetailsViewModel,child:
            BlocConsumer<MovieDetailsViewModel,MovieDetailsStates>(
              builder: (context, state) {
                if(state is MovieDetailsLoadingState){
                  return Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator(color: Colors.amber,)),
                    ],
                  ));
                }
                else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(width: double.infinity,
                      height: height*0.6,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            child: Image.network(
                              movieDetailsViewModel.movieDetailsResponse!.data!.movie!.largeCoverImage??
                                  movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumCoverImage!
                              ,
                              fit: BoxFit.fill,
                            ),
                            width: double.infinity,
                          ),
                          Container(
                              width: double.infinity,
                              child: Image.asset(AppImages.intro1shade,width: double.infinity,fit: BoxFit.fill,)),
                          Column(children: [
                            Spacer(),
                            Text(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.title!,
                              style: AppStyles.normal36white,
                            ),
                            Text("${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.year!}",
                              style: AppStyles.normal36white,
                            )
                          ],mainAxisAlignment: MainAxisAlignment.center,)
                        ],
                      ),
                    ),
                    Container(
                      height: height*0.07,
                      margin: EdgeInsets.symmetric(horizontal: width*0.02),
                      child: CustmElevatedButton(onpressed: ()async{
                        final uri = Uri.parse(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.url?? ""
                        );
                        await launchUrl (uri,mode:LaunchMode.inAppWebView);
                      },
                        text: "Watch",
                        BGcolor: Colors.red,
                        styleOfChild: AppStyles.regular20white,
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                    Row(children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: appColors.Lightblack),
                        child: Row(children: [SizedBox(width: width*0.02,),Icon(Icons.favorite,color: Colors.amber,),SizedBox(width: width*0.02,),
                          Text("${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.likeCount}",style: AppStyles.normal36white,),SizedBox(width: width*0.02,)],),
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: appColors.Lightblack),
                        child: Row(children: [SizedBox(width: width*0.02,),Icon(Icons.watch_later_rounded,color: Colors.amber,),SizedBox(width: width*0.02,),
                          Text("${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.runtime}",style: AppStyles.normal36white,),SizedBox(width: width*0.02,)],),
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: appColors.Lightblack),
                        child: Row(children: [SizedBox(width: width*0.02,),Icon(Icons.star_purple500_sharp,color: Colors.amber,),SizedBox(width: width*0.02,),
                          Text("${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.rating}",style: AppStyles.normal36white,),SizedBox(width: width*0.02,)],),
                      )
                    ],mainAxisAlignment: MainAxisAlignment.spaceAround,),
                    SizedBox(height: height*0.02,),
                    Text("Screen Shots",style: AppStyles.normal36white,),
                    SizedBox(height: height*0.02,),
                    ClipRRect(
                      child:Image.network(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.largeScreenshotImage1??
                          movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumScreenshotImage1!
                      ),
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                    SizedBox(height: height*0.02,),
                    ClipRRect(
                      child:Image.network(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.largeScreenshotImage2??
                          movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumScreenshotImage2!),
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                    SizedBox(height: height*0.02,),
                    ClipRRect(
                      child:Image.network(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.largeScreenshotImage3??
                          movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumScreenshotImage3!),
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                    SizedBox(height: height*0.02,),
                    Text("Similer",style: AppStyles.normal36white,),
                    SizedBox(
                      height:height*0.5
                      ,child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing:height*0.02,crossAxisSpacing: width*0.02),
                          itemBuilder: (context, index) {
                            return FilmItemBuilder(PassedMovie: movieDetailsViewModel.movieSuggestions!.data!.movies![index]);
                          },
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:movieDetailsViewModel.movieSuggestions==null?0: movieDetailsViewModel.movieSuggestions!.data!.movies!.length,
                          padding: EdgeInsets.zero,
                    ),
                    ),
                    SizedBox(height: height*0.02,),
                    Text("Summary",style: AppStyles.normal36white,),
                    SizedBox(height: height*0.02,),
                    Text(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.descriptionFull??
                        movieDetailsViewModel.movieDetailsResponse!.data!.movie!.descriptionIntro!,
                    style: AppStyles.regular20white,),
                    SizedBox(height: height*0.03,),
                    Text("Cast",style: AppStyles.normal36white,),
                    SizedBox(height: height*0.4,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
                        padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: appColors.Lightblack,),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              child: Image.network(movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumCoverImage??
                                  movieDetailsViewModel.movieDetailsResponse!.data!.movie!.mediumCoverImage!
                                ,fit: BoxFit.fill,width: width*0.09,height: height*0.06,),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.antiAlias,
                              //width: width*0.05,
                            ),
                            SizedBox(width: width*0.02,),
                            Column(children: [
                              Text("Name : ${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.cast![index].name}",style: AppStyles.white16_400,),
                              Text("Character : ${movieDetailsViewModel.movieDetailsResponse!.data!.movie!.cast![index].characterName}",style: AppStyles.white16_400,)
                            ],mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount:movieDetailsViewModel.movieDetailsResponse!.data!.movie!.cast?.length??0 ,
                      padding: EdgeInsets.zero,
                    ),
                    ),
                    SizedBox(height: height*0.03,),
                    Text("Genras",style: AppStyles.normal36white,),
                    SizedBox(height: height*0.05,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: appColors.Lightblack),
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        child:Text(
                          movieDetailsViewModel.movieDetailsResponse!.data!.movie!.genres![index],style:AppStyles.regular20white,),
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                        );
                      } ,
                      itemCount: movieDetailsViewModel.movieDetailsResponse!.data!.movie!.genres!.length,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                    ),
                    ),
                    SizedBox(height: height*0.03,),
                  ],
                );
                }
              },
              listener: (context, state) {
              },)
              ,);
          },itemCount: 1,padding: EdgeInsets.zero,),
          BlocProvider(create:(context)=> movieDetailsViewModel,child:
            BlocBuilder<MovieDetailsViewModel,MovieDetailsStates>(
              builder: (context, state) {
                return Container(width: double.infinity,height: height*0.13,color: Colors.transparent,
                  child: Row(children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
                    Spacer(),
                    IconButton(
                        onPressed: ()async{
                          if(movieDetailsViewModel.isFavorite==true){
                            await ApiManager.DeleteMovieFromFavorite(tokin: provider.CurrentUserTokin!,
                                MovieID: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.id!);
                            movieDetailsViewModel.IsFavorite(tokin: provider.CurrentUserTokin!,
                                MovieID: movieDetailsViewModel.movieDetailsResponse!.data!.movie!.id!);
                            ShowDialogUtils.ShowMessage(context, Title: "",
                                Content:"Deleted from Favorite" ,
                                NigActionName: "Ok",
                              NigAction: (){Navigator.pop(context);}
                            );
                            provider.DeletMovieFromFavorite(MovieID: movieDetailsViewModel.movieDetailsResponse!
                                .data!.movie!.id!);
                          }else{
                            await movieDetailsViewModel.AddToFavorit(
                                tokin: provider.CurrentUserTokin!,
                                MovieID: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.id!,
                                name: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.titleEnglish!,
                                rateing: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.rating ?? 0,
                                year: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.year.toString(),
                                imageURL: movieDetailsViewModel
                                    .movieDetailsResponse!.data!.movie!
                                    .largeCoverImage ??
                                    movieDetailsViewModel.movieDetailsResponse!
                                        .data!.movie!.mediumCoverImage!);
                            movieDetailsViewModel.IsFavorite(tokin: provider.CurrentUserTokin!,
                                MovieID: movieDetailsViewModel.movieDetailsResponse!.data!.movie!.id!);

                            provider.AddMovieToFavorite(MovieID: movieDetailsViewModel.movieDetailsResponse!
                                .data!.movie!.id!,
                                name: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.titleEnglish!,
                                rateing: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.rating ?? 0,
                                year: movieDetailsViewModel.movieDetailsResponse!
                                    .data!.movie!.year.toString(),
                                imageURL: movieDetailsViewModel
                                    .movieDetailsResponse!.data!.movie!
                                    .largeCoverImage ??
                                    movieDetailsViewModel.movieDetailsResponse!
                                        .data!.movie!.mediumCoverImage!);
                            ShowDialogUtils.ShowMessage(context, Title: "",
                                Content: "Added To Favorite",
                                NigActionName: "Ok");
                          }
                        },icon: movieDetailsViewModel.isFavorite==true?Icon(Icons.favorite,color: Colors.white,):Icon(Icons.favorite_border,color: Colors.white,)

                    ),
                  ],),
                );
              },

            )
          )
        ],
      )
    );
  }
}
//movieDetailsViewModel.movieDetailsResponse!.data!.movie!.