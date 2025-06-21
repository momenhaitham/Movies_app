import 'package:flutter/material.dart';
import 'package:movies_app/Tabs/browse_tab/browse_tab.dart';
import 'package:movies_app/Tabs/home_tab/home_tab.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab.dart';
import 'package:movies_app/Tabs/search_tab/search_tab.dart';
import 'package:movies_app/providers/app_provider.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_icons.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider provider;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      provider.ReadTokin();
      await provider.GetProfileData(provider.CurrentUserTokin!);
      await provider.getFavoriteMovies(tokin: provider.CurrentUserTokin!);
      await provider.ReadHistory();
    });
  }

  @override
  List<Widget>Tabs=[
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab()
  ];

  int selectedItem=0;
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    provider = Provider.of<AppProvider>(context);
    if(provider.ProfileData==null&&provider.CurrentUserTokin!=null){
      provider.GetProfileData(provider.CurrentUserTokin!);
    }
    return Scaffold(
      backgroundColor: appColors.black,
      //bottomNavigationBar:

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Tabs[selectedItem],
          Container(width: double.infinity,height: height*0.06,
          margin: EdgeInsets.only(bottom: height*0.03,left:width*0.03 ,right: width*0.03),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: appColors.Lightblack),
          child: Row(children: [
            Expanded(child: InkWell(child: Image.asset(selectedItem==0?appIcons.HomeSelected:appIcons.HomeUnselected),onTap: (){selectedItem=0;setState(() {});},)),
            Expanded(child: InkWell(child: Image.asset(selectedItem==1?appIcons.SearchSelected:appIcons.SearchUnselected),onTap: (){selectedItem=1;setState(() {});},)),
            Expanded(child: InkWell(child: Image.asset(selectedItem==2?appIcons.BrowseSelected:appIcons.BrowseUnselected),onTap: (){selectedItem=2;setState(() {});},)),
            Expanded(child: InkWell(child: Image.asset(selectedItem==3?appIcons.ProfileSelected:appIcons.ProfileUnselected),onTap: (){selectedItem=3;setState(() {});},)),
          ],),
          )
        ],
      ),
    );
  }
}
