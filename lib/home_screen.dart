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
    var provider = Provider.of<AppProvider>(context);
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
/*
Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: appColors.Lightblack),
        margin: EdgeInsets.all(30),
        width: double.infinity,
        height: height*0.0872,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor:Colors.transparent),
          child:BottomNavigationBar(items: [
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.HomeSelected),icon:Image.asset(appIcons.HomeUnselected),label:""),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.SearchSelected),icon:Image.asset(appIcons.SearchUnselected),label:""),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.BrowseSelected),icon:Image.asset(appIcons.BrowseUnselected),label:""),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.ProfileSelected),icon:Image.asset(appIcons.ProfileUnselected),label:""),
          ],
            showUnselectedLabels: false,
            elevation: 0,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            type: BottomNavigationBarType.shifting,
            currentIndex:selectedItem ,
            showSelectedLabels: false,
            onTap: (selected){
              selectedItem=selected;
              setState(() {});
            },
          ),
        ),
      ),
 */
