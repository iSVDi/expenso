import 'package:expenso/common/app_preferences.dart';
import 'package:flutter/material.dart';

class SettingsCubit {
  final _appPrefs = AppPreferences();

  TimeOfDay getTime() => _appPrefs.getReminderTime();

  String getForamttedTime() {
    var time = _appPrefs.getReminderTime();
    var hours = time.hour.toString().padLeft(2, "0");
    var minutes = time.minute.toString().padLeft(2, "0");
    var res = "$hours:$minutes";
    return res;
  }

  void setTime(TimeOfDay time) => _appPrefs.setReminderTime(time);

  bool getSwitchState() => _appPrefs.getReminderState();
  void switchHandler(bool value) => _appPrefs.setRemindetState(value);
}
