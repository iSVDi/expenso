import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/notifications/notifications_service.dart';

///INFO: using for update strings after changing locale
class AppLocalizator {
  late AppLocalizations _localizations;
  final _prefs = AppPreferences();
  final _notificationService = NotificationsService();

  void update(AppLocalizations localizations) {
    _localizations = localizations;
    _localizeNotification();
  }

//TODO don't need. Set localizations inside _notificationService.scheduleNotifications (param of awesome.createNotification)
  void _localizeNotification() {
    if (_prefs.getReminderState()) {
      var time = _prefs.getReminderTime();
      var now = DateTime.now();
      var reminderTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);

      _notificationService.scheduleNotifications(
        title: _localizations.notificationTitle,
        body: _localizations.notificationBody,
        scheduledNotificationDateTime: reminderTime,
      );
    }
  }
}
