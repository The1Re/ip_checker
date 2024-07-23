import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ip_checker/model/device.dart';


class ShowNotification {

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');


    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notification_id, title, value, notificationDetails, payload: 'Not present');
  }


  void scheduleNotifications(Device device) {
  Timer.periodic(Duration(seconds: 10), (Timer timer) {
    showNotificationAndroid("Your ${device.name} is down","Your ${device.name} is currently not working. Please check your device."); // Alert when status is offline.....
  });
}
}