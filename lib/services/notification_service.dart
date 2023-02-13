import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {

  static Future<void> askForPermission() async {
    await Permission.notification.request();
  }

  static Future<void> sendNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse
    );

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'notification',
      'Notification',
      channelDescription: 'The notification channel.',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      ticker: 'Some ticker text.',
      actions: [
        AndroidNotificationAction("1", "Click")
      ]
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        UniqueKey().hashCode,
        'Watchlist',
        'You have items in your watchlist bro.',
        notificationDetails,
        payload: 'Redirect to watchlist'
    );
    print("Notifications done ...");
  }

  static Future<void> _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

}