// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/categories_repository.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:expenso/notifications/notifications_service.dart';

///INFO: using for update strings after changing locale
class AppLocalizator {
  late AppLocalizations _localizations;
  final _prefs = AppPreferences();
  final _notificationService = NotificationsService();

  void update(AppLocalizations localizations) {
    _localizations = localizations;
    _localizeEmptyCategoryTitle();
    _localizeNotification();
  }

  void _localizeEmptyCategoryTitle() {
    var emptyCategory = Category.emptyCategory();
    emptyCategory.title = _localizations.noCategory;
    var repository = CategoriesRepository();
    repository.insertCategory(emptyCategory);
  }

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