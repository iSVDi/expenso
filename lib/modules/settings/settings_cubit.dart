import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/notifications/notifications_service.dart';
import 'package:flutter/material.dart';

class SettingsCubit {
  final _appPrefs = AppPreferences();
  final _notificationsService = NotificationsService();

  TimeOfDay getTime() => _appPrefs.getReminderTime();

  String getForamttedTime() {
    var time = _appPrefs.getReminderTime();
    var hours = time.hour.toString().padLeft(2, "0");
    var minutes = time.minute.toString().padLeft(2, "0");
    var res = "$hours:$minutes";
    return res;
  }

  void setTime(TimeOfDay time) {
    _appPrefs.setReminderTime(time);
    switchHandler(true);
  }

  bool getSwitchState() => _appPrefs.getReminderState();

  void switchHandler(bool value) {
    _appPrefs.setReminderState(value);
    if (value) {
      _notificationsService.initNotification();
      _setupNotifications();
    } else {
      _notificationsService.cancelNotifications();
    }
  }

  void _setupNotifications() {
    var now = DateTime.now();
    var timeOfDay = _appPrefs.getReminderTime();

    var dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    //TODO localize
    _notificationsService.scheduleNotifications(
      title: "title",
      body: "body",
      scheduledNotificationDateTime: dateTime,
    );
  }
}
