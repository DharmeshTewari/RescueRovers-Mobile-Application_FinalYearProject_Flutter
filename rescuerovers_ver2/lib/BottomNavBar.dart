import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:rescuerovers/Home.dart';
import 'package:rescuerovers/Loaction_googlemaps.dart';
import 'package:rescuerovers/Login&Signup/NearestFosterHomes.dart';
import 'package:rescuerovers/favourite.dart';
import 'package:rescuerovers/fosterhomes.dart';
import 'package:rescuerovers/userdeatils.dart';

class BottomNavbarrr extends StatefulWidget {
  const BottomNavbarrr({super.key});

  @override
  State<BottomNavbarrr> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbarrr> {
  final List screens = [
    HomePage(),
    FavouritePage(),
    NearestAdoption(),
    UserDetailsPage(),
  ];
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedindex,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 32, 32, 32),
        items: const [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.home_filled,
              color: Color.fromARGB(255, 255, 174, 0),
            ),
            label: 'Home',
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 174, 0)),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 255, 174, 0),
            ),
            label: 'Favourites',
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 174, 0)),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.pets_outlined,
                color: Color.fromRGBO(255, 174, 0, 1)),
            label: 'Locations',
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 174, 0)),
          ),
          CurvedNavigationBarItem(
            child:
                Icon(Icons.person_2, color: Color.fromARGB(255, 255, 174, 0)),
            label: 'User',
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 174, 0)),
          ),
        ],
        onTap: (index) {
          print(index);
          // Handle button tap
          setState(() {
            _selectedindex = index;
          });
        },
      ),
      body: screens[_selectedindex],
    );
  }
}
