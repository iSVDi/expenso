import 'package:expenso/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _AppPreferencesKeys {
  theme,
  isFirstLaunch,
  reminderTime,
  reminderState,
}

typedef _PrefsKeys = _AppPreferencesKeys;

class AppPreferences {
  SharedPreferences get _sharedPrefs =>
      sharedPreferencesKeeper.getSharedPreferences;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _sharedPrefs.setString(_PrefsKeys.theme.name, themeMode.name);
  }

  ThemeMode getThemeMode() {
    var name =
        _sharedPrefs.getString(_PrefsKeys.theme.name) ?? ThemeMode.system.name;
    var themeMode =
        ThemeMode.values.firstWhere((element) => element.name == name);
    return themeMode;
  }

  bool getIsFirstLaunch() =>
      _sharedPrefs.getBool(_PrefsKeys.isFirstLaunch.name) ?? true;

  void setIsNotFirstLaunch() {
    _sharedPrefs.setBool(_PrefsKeys.isFirstLaunch.name, false);
  }

  void setReminderTime(TimeOfDay time) => _sharedPrefs.setStringList(
      _PrefsKeys.reminderTime.name, ["${time.hour}", "${time.minute}"]);

  TimeOfDay getReminderTime() {
    var value = _sharedPrefs.getStringList(_PrefsKeys.reminderTime.name);
    TimeOfDay res;
    if (value == null) {
      res = const TimeOfDay(hour: 20, minute: 0);
    } else {
      res = TimeOfDay(hour: int.parse(value[0]), minute: int.parse(value[1]));
    }
    return res;
  }

  void setRemindetState(bool state) =>
      _sharedPrefs.setBool(_PrefsKeys.reminderState.name, state);

  bool getReminderState() =>
      _sharedPrefs.getBool(_PrefsKeys.reminderState.name) ?? false;
}
