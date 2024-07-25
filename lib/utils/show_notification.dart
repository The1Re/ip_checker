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

  void showNotificationAndroid(String title, String value, int noti_id) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notificationId = noti_id;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notificationId, title, value, notificationDetails, payload: 'Not present');
  }

  void showNotification(Device device, int id) {
    showNotificationAndroid("[ ${device.name} ] is down", "[ ${device.ip} ] is currently not working. Please check your device.", id);
  }

  Future<void> closeNotification(int notiId) async {
    await flutterLocalNotificationsPlugin.cancel(notiId);
  }

}