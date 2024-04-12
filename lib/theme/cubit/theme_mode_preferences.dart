import 'package:expenso/main.dart';
import 'package:flutter/material.dart';

class ThemeModePreferences {
  var key = "theme_mode_key";
  final _themeModes = ThemeMode.values;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setString(key, themeMode.name);
  }

  ThemeMode getThemeMode() {
    var name = sharedPreferences.getString(key) ?? ThemeMode.system.name;
    var themeMode = _themeModes.firstWhere((element) => element.name == name);
    return themeMode;
  }
}
