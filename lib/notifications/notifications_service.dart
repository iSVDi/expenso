
//TODO! reminder add handler of displaying notification
class NotificationsService {
  static const _reminderNotificationID = 0;
  Future<void> initNotification() async {
    //TODO! reminder implement
  }

  Future scheduleNotifications(
      {int id = _reminderNotificationID,
      required String title,
      required String body,
      required DateTime scheduledNotificationDateTime}) async {
        //TODO! reminder implement
      }

  Future cancelNotifications() async {
    //TODO! reminder implement
  }
}
