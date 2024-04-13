import 'package:flutter/material.dart';
import 'package:todo_tracker/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool lightTheme = true;

  ThemeProvider() {
    _initializeTheme();
  }

  ThemeData get themeData => _themeData;

  Future<void> _initializeTheme() async {
    bool? isLightMode = await readTheme('theme');
    if (isLightMode != null) {
      isLightMode == true ? _themeData = lightMode : _themeData = darkMode;
      notifyListeners();
    }
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      lightTheme = false;
    } else {
      themeData = lightMode;
      lightTheme = true;
    }

    _saveTheme('theme', lightTheme);
    notifyListeners();
  }

  static Future _saveTheme(String key, bool isLightTheme) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, isLightTheme);
  }

  static Future readTheme(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
