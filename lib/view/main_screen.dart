import 'package:flutter/material.dart';
import 'package:hotel_booking/view/explore_screen.dart';
import 'package:hotel_booking/view/message_screen.dart';
import 'package:hotel_booking/view/profile_screen.dart';
import 'package:hotel_booking/view/trip_screen.dart';
import 'package:hotel_booking/view/wishlist.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> page = [
    const ExploreScreen(),
    const Wishlist(),
    const TripScreen(),
    const MessageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        selectedFontSize: 15.0,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Explore',
              icon: Image.network(
                'https://static-00.iconduck.com/assets.00/search-icon-2048x2048-4r9dtbbw.png',
                color: selectedIndex == 0 ? Colors.red : Colors.black45,
                height: 28.0,
              )),
          const BottomNavigationBarItem(
              label: 'Wishlists',
              icon: Icon(
                Icons.favorite_border,
              )),
          BottomNavigationBarItem(
            label: 'Trip',
            icon: Image.network(
                color: selectedIndex == 2 ? Colors.red : Colors.black45,
                'https://cdn-icons-png.flaticon.com/512/2111/2111307.png',
                height: 28.0),
          ),
          BottomNavigationBarItem(
            label: 'Message',
            icon: Image.network(
                color: selectedIndex == 3 ? Colors.red : Colors.black45,
                'https://cdn0.iconfinder.com/data/icons/mobile-basic-vol-1/32/Chat-1024.png',
                height: 28.0),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Image.network(
                color: selectedIndex == 4 ? Colors.red : Colors.black45,
                'https://cdn2.iconfinder.com/data/icons/user-interface-line-38/24/Untitled-5-19-1024.png',
                height: 28.0),
          ),
        ],
      ),
    );
  }
}
