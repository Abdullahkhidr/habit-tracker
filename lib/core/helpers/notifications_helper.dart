import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeTimezone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> initializeAwesomeNotifications() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'habit_channel',
        channelName: 'Habit Notifications',
        channelDescription: 'Notifications for habit reminders',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );

  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

Future<void> initializeWorkmanager() async {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager().registerPeriodicTask(
    'rescheduleNotifications',
    'rescheduleTask',
    frequency: const Duration(hours: 24),
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'habitNotificationTask':
        await triggerHabitNotification(inputData);
        if (inputData != null &&
            inputData.containsKey('weekday') &&
            inputData.containsKey('hour') &&
            inputData.containsKey('minute')) {
          int weekday = inputData['weekday'];
          int hour = inputData['hour'];
          int minute = inputData['minute'];
          TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
          await scheduleHabitNotificationForDay(weekday, time);
        }
        break;

      case 'rescheduleTask':
        await rescheduleAllNotifications();
        break;
    }
    return Future.value(true);
  });
}

Future<void> triggerHabitNotification(Map<String, dynamic>? inputData) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'habit_channel',
      title: 'Habit Reminder',
      body: 'Time to complete your habit!',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<void> scheduleWeeklyHabitNotifications(
    List<int> days, TimeOfDay time) async {
  for (int day in days) {
    await scheduleHabitNotificationForDay(day, time);
  }
}

Future<void> scheduleHabitNotificationForDay(
    int weekday, TimeOfDay time) async {
  tz.TZDateTime scheduledDate = _nextInstanceOfWeekdayTime(weekday, time);

  await Workmanager().registerOneOffTask(
    'habitNotification_$weekday',
    'habitNotificationTask',
    inputData: {
      'weekday': weekday,
      'hour': time.hour,
      'minute': time.minute,
    },
    initialDelay: scheduledDate.difference(tz.TZDateTime.now(tz.local)),
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    ),
  );

  await persistScheduledDay(weekday, time);
}

tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, TimeOfDay time) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  while (scheduledDate.weekday != weekday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 7));
  }

  return scheduledDate;
}

Future<void> persistScheduledDay(int weekday, TimeOfDay time) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> scheduledDays = prefs.getStringList('scheduledDays') ?? [];
  String dayEntry = '$weekday:${time.hour}:${time.minute}';
  if (!scheduledDays.contains(dayEntry)) {
    scheduledDays.add(dayEntry);
    await prefs.setStringList('scheduledDays', scheduledDays);
  }
}

Future<void> rescheduleAllNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> scheduledDays = prefs.getStringList('scheduledDays') ?? [];
  for (String dayEntry in scheduledDays) {
    List<String> parts = dayEntry.split(':');
    if (parts.length == 3) {
      int weekday = int.parse(parts[0]);
      int hour = int.parse(parts[1]);
      int minute = int.parse(parts[2]);
      TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
      await scheduleHabitNotificationForDay(weekday, time);
    }
  }
}
