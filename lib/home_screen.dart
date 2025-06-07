import 'package:flutter/material.dart';
import 'package:movies_app/Tabs/home_tab/home_tab.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_icons.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<Widget>Tabs=[
    HomeTab(),
  ];

  int selectedItem=0;
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
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
      body: Tabs[selectedItem],
    );
  }
}

/*
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor:Colors.transparent),
          child:BottomNavigationBar(items: [
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.HomeSelected),icon:Image.asset(appIcons.HomeUnselected),label:"Home"),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.MapSelected),icon:Image.asset(appIcons.MapUnselected),label:"Map"),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.LoveSelected),icon:Image.asset(appIcons.LoveUnselected),label:"Love"),
            BottomNavigationBarItem(activeIcon:Image.asset(appIcons.ProfileSelected),icon:Image.asset(appIcons.ProfileUnselected),label:"Profile"),
          ],
            elevation: 0,
            currentIndex:selectedItem ,
            onTap: (selected){
              selectedItem=selected;
              setState(() {});
            },
          ),
        ),
      ),
 */
