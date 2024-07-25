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

  void showNotificationAndroid(String title, String value,int noti_id) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.min,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = noti_id;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notification_id, title, value, notificationDetails, payload: 'Not present');
  }


  void scheduleNotifications(Device device,int noti_id) {
    showNotificationAndroid("Your ${device.name} is down","Your ${device.name} is currently not working. Please check your device.",noti_id); // Alert when status is offline.....
  }

  Future<void> closeNotification(int noti_id) async {
    await flutterLocalNotificationsPlugin.cancel(noti_id);
  }
}