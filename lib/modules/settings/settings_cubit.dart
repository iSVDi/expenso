import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
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

  void setTime(BuildContext context, TimeOfDay time) {
    _appPrefs.setReminderTime(time);
    switchHandler(context, true);
  }

  bool getSwitchState() => _appPrefs.getReminderState();

  void switchHandler(BuildContext context, bool value) {
    _appPrefs.setReminderState(value);
    if (value) {
      _setupNotifications(context);
    } else {
      _notificationsService.cancelNotifications();
    }
  }

  void _setupNotifications(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        var now = DateTime.now();
        var timeOfDay = _appPrefs.getReminderTime();

        var dateTime = DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

        var localization = AppLocalizations.of(context)!;
        _notificationsService.scheduleNotifications(
          title: localization.notificationTitle,
          body: localization.notificationBody,
          scheduledNotificationDateTime: dateTime,
        );
      }
    });
  }
}
