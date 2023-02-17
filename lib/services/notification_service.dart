import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails = AndroidNotificationDetails(
    '2',
    'movie-night',
    channelDescription: "This is the channel, responsible for local notifications",
    importance: Importance.high,
    priority: Priority.high,
    color: Colors.amber,
    colorized: true,
    playSound: true,
    groupKey: "1",
    subText: "Browse your favourite movies.",
  );

  static const NotificationDetails _notificationDetails = NotificationDetails(android: _androidNotificationDetails);

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Belgrade"));

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    await _scheduleNotification();
  }

  Future<void> askForPermission() async {
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  Future<void> _scheduleNotification() async {
    // First we cancel all the previous notifications
    await _flutterLocalNotificationsPlugin.cancelAll();

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      UniqueKey().hashCode,
      'Movie night',
      'Browse your favourite movies and TV shows and find something to watch tonight.',
      tz.TZDateTime.from(DateTime(2023, 2, 17, 20, 00), tz.getLocation("Europe/Belgrade")),
      _notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
    );
  }

  Future<void> showNotification(String? name) async {
    await _flutterLocalNotificationsPlugin.show(
        UniqueKey().hashCode,
        'Movie night',
        "Welcome to the application${name == null ? '' : ' $name'}! Thank you for signing in.",
        _notificationDetails,
    );
  }

  static Future<void> _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    // final String? payload = notificationResponse.payload;
    // await navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => DetailsPage(payload: payload)));
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

}