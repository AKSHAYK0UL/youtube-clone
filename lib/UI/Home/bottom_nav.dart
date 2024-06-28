import 'package:flutter/material.dart';
import 'package:youtube/UI/Home/account.dart';
import 'package:youtube/UI/Home/homescreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int _currentIndex = 0;

class _BottomNavState extends State<BottomNav> {
  List<Widget> Screens = [
    const HomeScreen(),
    const Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: Screens),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black12,
        indicatorColor: Colors.white,
        selectedIndex: _currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(label: "Home", icon: Icon(Icons.home)),
          NavigationDestination(label: "Account", icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
