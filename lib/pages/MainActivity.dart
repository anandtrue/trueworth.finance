import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/pages/Main_page.dart';
import 'package:trueworthfinance/pages/daily_page.dart';
import 'package:trueworthfinance/pages/transection_page.dart';

class MainActivity extends StatefulWidget {
  final String fullName;
  final String mobile;
  final String pan;

  // Define the constructor with named parameters
  MainActivity({
    required this.fullName,
    required this.mobile,
    required this.pan,
  });

  @override
  State<MainActivity> createState() => _HomePageState();
}

class _HomePageState extends State<MainActivity> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      MainPage(),
      TransectionPage(),
      TransectionPage(),
      TransectionPage(),
      DailyPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        textStyle: const TextStyle(
          fontSize: 12,
          color: secondary, // Active text color
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.credit_card),
        title: "Cards",
        textStyle: const TextStyle(
          fontSize: 12,
          color: secondary, // Active text color
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.money),
        title: "Money",
        textStyle: const TextStyle(
          fontSize: 12,
          color: secondary, // Active text color
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Profile",
        textStyle: const TextStyle(
          fontSize: 12,
          color: secondary, // Active text color
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Settings",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
        textStyle: const TextStyle(
          fontSize: 12,
          color: secondary, // Active text color
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: secondary3,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style7, // Use Style 7
    );
  }
}
