import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Belgrade"));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    await _scheduleNotification();
  }

  Future<void> askForPermission() async {
    // await Permission.notification.request();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  Future<void> _scheduleNotification() async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
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
      actions: [
        AndroidNotificationAction("favourites", "Favourites"),
        AndroidNotificationAction("watchlist", "Watchlist"),
        AndroidNotificationAction("history", "History"),
      ]
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      UniqueKey().hashCode,
      'Movie night',
      'Browse your favourite movies and TV shows and find something to watch tonight.',
      tz.TZDateTime.from(DateTime(2023, 2, 16, 20, 00), tz.getLocation("Europe/Belgrade")),
      notificationDetails,
      payload: 'Redirect to watchlist',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
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