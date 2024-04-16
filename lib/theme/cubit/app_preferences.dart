import 'package:expenso/main.dart';
import 'package:flutter/material.dart';

enum _AppPreferencesKeys {
  theme,
  isFirstLaunch,
}

//TODO key must be private
//? where should be this file
class AppPreferences {
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setString(
        _AppPreferencesKeys.theme.name, themeMode.name);
  }

  ThemeMode getThemeMode() {
    var name = sharedPreferences.getString(_AppPreferencesKeys.theme.name) ??
        ThemeMode.system.name;
    var themeMode =
        ThemeMode.values.firstWhere((element) => element.name == name);
    return themeMode;
  }

  bool getIsFirstLaunch() {
    var res =
        sharedPreferences.getBool(_AppPreferencesKeys.isFirstLaunch.name) ??
            true;
    return res;
  }

  void setIsNotFirstLaunch() {
    sharedPreferences.setBool(_AppPreferencesKeys.isFirstLaunch.name, false);
  }
}
