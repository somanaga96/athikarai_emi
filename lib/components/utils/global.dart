import 'package:flutter/material.dart';

class Global extends ChangeNotifier{
  bool _isDarkMode = true;
   bool get isDarkMode => _isDarkMode;
  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle the theme mode
    notifyListeners();
  }
   ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }
}