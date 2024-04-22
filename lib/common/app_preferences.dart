import 'package:expenso/main.dart';
import 'package:flutter/material.dart';

enum _AppPreferencesKeys {
  theme,
  isFirstLaunch,
}

class AppPreferences {
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await sharedPreferencesKeeper.getSharedPreferences
        .setString(_AppPreferencesKeys.theme.name, themeMode.name);
  }

  ThemeMode getThemeMode() {
    var name = sharedPreferencesKeeper.getSharedPreferences
            .getString(_AppPreferencesKeys.theme.name) ??
        ThemeMode.system.name;
    var themeMode =
        ThemeMode.values.firstWhere((element) => element.name == name);
    return themeMode;
  }

  bool getIsFirstLaunch() {
    var res = sharedPreferencesKeeper.getSharedPreferences
            .getBool(_AppPreferencesKeys.isFirstLaunch.name) ??
        true;
    return res;
  }

  void setIsNotFirstLaunch() {
    sharedPreferencesKeeper.getSharedPreferences
        .setBool(_AppPreferencesKeys.isFirstLaunch.name, false);
  }
}
