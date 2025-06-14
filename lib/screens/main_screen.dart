import 'package:flutter/material.dart';
import 'package:KAS/screens/favorite_screen.dart';
import 'package:KAS/screens/home_screen.dart';
import 'package:KAS/screens/more_screen.dart';
import 'package:KAS/screens/notification_screen.dart';

class MainScreen extends StatefulWidget {
  final String email;

  const MainScreen({super.key, required this.email});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screenList = [
      HomeScreen(email: widget.email),
      const FavoriteScreen(),
      const NotificationScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: screenList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blueGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
