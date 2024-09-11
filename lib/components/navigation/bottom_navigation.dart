import 'package:flutter/material.dart';
import '../home.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  late List<Widget> screen;

  @override
  void initState() {
    super.initState();
    screen = const [
      Home(),
      Home(),
      Home(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Update title based on selected index
          // global.updateCurrentPageTitle(_getPageTitle(index));
        },
        selectedFontSize: 18,
        iconSize: 25,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Debt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
