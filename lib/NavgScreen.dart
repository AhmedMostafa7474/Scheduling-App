import 'package:day_by_day_app/CalendarPage.dart';
import 'package:day_by_day_app/HomePage.dart';
import 'package:day_by_day_app/SchedulingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class navgscreen extends StatefulWidget {
  @override
  _navgscreenState createState() => _navgscreenState();
}

class _navgscreenState extends State<navgscreen> {
   PersistentTabController _controller=PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
       onItemSelected: (int){
        setState(() {

        });
       },
    );
  }
   List<Widget> _buildScreens() {
     return [
       homepage(DateTime.now()),
       //schedulingPage()
       calenderpage()
     ];
   }

   List<PersistentBottomNavBarItem> _navBarsItems() {
     return [
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.home),
         title: ("Home"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.calendar_badge_minus),
         title: ("Settings"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
     ];
   }


}
