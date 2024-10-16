import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  final awesomeNotification = AwesomeNotifications();
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required List<int> daysOfWeek,
  }) async {
    for (int dayOfWeek in daysOfWeek) {
      await awesomeNotification.createNotification(
        content: NotificationContent(
          id: id + dayOfWeek,
          channelKey: 'scheduled_channel',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
          weekday: dayOfWeek,
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      );
    }
  }

  Future<void> cancelWeeklyNotifications(int taskId) async {
    for (int day = 1; day <= 7; day++) {
      await awesomeNotification.cancel(taskId + day);
    }
  }
}
