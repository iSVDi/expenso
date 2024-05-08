import 'package:awesome_notifications/awesome_notifications.dart';

/*
TODO: need resolve for iOS
[ERROR:flutter/shell/platform/darwin/graphics/FlutterDarwinContextMetalImpeller.mm(42)] Using the Impeller rendering backend.
Connecting to VM Service at ws://127.0.0.1:57617/bh6oBrdMlUM=/ws
[ERROR:flutter/shell/common/shell.cc(1015)] The 'awesome_notifications' channel sent a message from native to Flutter on a non-platform thread. Platform channel messages must be sent on the platform thread. Failure to do so may result in data loss or crashes, and must be fixed in the plugin or application code creating that channel.
See https://docs.flutter.dev/platform-integration/platform-channels#channels-and-platform-threading for more information.
Lost connection to device.
*/
//TODO test badges on real android device
class NotificationsService {
  static const _reminderNotificationID = 0;
  static const _channelKey = 'basic_channel';
  final awesome = AwesomeNotifications();
  Future initialize() async {
    await awesome.initialize(
        "resource://drawable/ic_splash_white_logo",
        [
          NotificationChannel(
              channelShowBadge: true,
              importance: NotificationImportance.Max,
              channelGroupKey: 'basic_channel_group',
              channelKey: _channelKey,
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests'),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
    await resetGlobalBadge();
  }

  ///INFO: Only after setListeners being called, the notification events starts to be delivered.
  Future setListeners() async {
    await awesome.setListeners(
      onActionReceivedMethod: _NotificationController.onActionReceivedMethod,
    );
  }

  Future scheduleNotifications(
      {required String title,
      required String body,
      required DateTime scheduledNotificationDateTime}) async {
    var badgeCounter = await awesome.getGlobalBadgeCounter() + 1;
    var notificationContent = NotificationContent(
        id: _reminderNotificationID,
        channelKey: _channelKey,
        title: title,
        badge: badgeCounter,
        body: body,
        largeIcon: 'asset://assets/app_logo.png');

    var localTimeZone = await awesome.getLocalTimeZoneIdentifier();
    awesome.createNotification(
      content: notificationContent,
      schedule: NotificationCalendar(
        hour: scheduledNotificationDateTime.hour,
        minute: scheduledNotificationDateTime.minute,
        timeZone: localTimeZone,
      ),
    );
  }

  Future cancelNotifications() async {
    await awesome.cancel(_reminderNotificationID);
  }

  Future resetGlobalBadge() async {
    await awesome.resetGlobalBadge();
  }
}

class _NotificationController {
  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
