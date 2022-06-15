import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import 'main/deviation_home_screen.dart';
import 'main/favourite_screen.dart';
import 'main/home_screen.dart';

//Wrapper class which wraps everthing (can be thought as the most outmost screen that consists
//of home, find and bookings screens

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  final _screens = [
    HomeScreen(),
    DeviationHomeScreen(),
    FavouriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: _currentIndex == 0 ? primaryColor : Colors.grey,
                height: 25,
              ),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/turbine.svg",
                color: _currentIndex == 1 ? primaryColor : Colors.grey,
                height: 25,
              ),
              label: 'Deviations'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/favourite.svg",
                color: _currentIndex == 2 ? primaryColor : Colors.grey,
                height: 25,
              ),
              label: 'Favourites'
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}