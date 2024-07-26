import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/home.dart';
import 'package:ip_checker/utils/show_notification.dart';
import 'package:ip_checker/utils/sqlite_helper.dart';
import 'package:http/http.dart' as http;
import 'package:ip_checker/utils/utils.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      // notificationChannelId: 'my_foreground',
      // initialNotificationContent: 'running',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
      print(event);
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  List<Device> _devices = [];

  await SQLiteHelper().getDevice().then((deviceList) {
    _devices = deviceList;
  });

  Pingonforeground pingonforeground = Pingonforeground(devices: _devices);

  // // bring to foreground
  Timer.periodic(const Duration(seconds: 30), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        pingonforeground.pingAll();
      }
    }
  });
}

class Pingonforeground {
  Pingonforeground({required this.devices});
  List<Device> devices;
  final List<StreamSubscription<void>> _subsciptions = [];

  Future<void> pingAll() async {
    for (var device in devices) {
      device.type == Type.icmp
          ? await pingWithICMP(device)
          : await pingWithHTTP(device);
    }
  }

  Future<void> pingWithICMP(Device device) async {
    int deviceIdx = devices.indexWhere((item) => item.name == device.name);
    final ping = Ping(
      device.ip,
      count: 1,
      timeout: 5,
      ipv6: false,
    );
    final subsciption = ping.stream.listen((event) async {
      if (event.error == null) {
        if (event.response == null) {
          if (event.summary?.received != 0) {//Online
            Device update = Device(
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.online);
            await SQLiteHelper().update(device.name, update);
            ShowNotification().closeNotification(deviceIdx);
          } else {
            Device update = Device(//Offline
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.offline);
            await SQLiteHelper().update(device.name, update);
            ShowNotification().showNotification(device, deviceIdx);
          }
        }
      } else {
        Device update = Device(//Offline
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.offline);
            await SQLiteHelper().update(device.name, update);
        ShowNotification().showNotification(device, deviceIdx);
      }
    }).asFuture();
    _subsciptions.add(subsciption.asStream().listen((event) {}));
  }

  Future<void> pingWithHTTP(Device device) async {
    int deviceIdx =
        devices.indexWhere((item) => item.name == device.name);
    try {
      http.Response response = await http.get(Uri.parse("https://${device.ip}"),
          headers: {
            "Accept": "application/json"
          }).timeout(const Duration(minutes: 3));
      if (response.statusCode != 200) { //Offline
        Device update = Device(
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.offline);
            await SQLiteHelper().update(device.name, update);
        ShowNotification().showNotification(device, deviceIdx);
      } else {
        final data = jsonDecode(response.body);
        Duration diff = getDifferenceTime(data['time'] as int);
        if (diff.inSeconds > 60) {//Lowonline
          Device update = Device(
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.lowOnline);
            await SQLiteHelper().update(device.name, update);
        } else {//Online
          Device update = Device(
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.online);
            await SQLiteHelper().update(device.name, update);
        }
        ShowNotification().closeNotification(deviceIdx);
      }
    } catch (_) {//Offline
      Device update = Device(
                        name: device.name,
                        ip: device.ip,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now(),
                        status: Status.offline);
            await SQLiteHelper().update(device.name, update);
      ShowNotification().showNotification(device, deviceIdx);
    }
  }
}
