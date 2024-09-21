import 'package:athikarai_emi/components/page/calc/calc_home.dart';
import 'package:athikarai_emi/components/page/settings.dart';
import 'package:flutter/material.dart';
import '../page/home.dart';

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
    screen = [ const CalcHome(),
     const Home(), const Settings()];
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
