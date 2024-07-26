import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/add_device.dart';
import 'package:ip_checker/utils/show_notification.dart';
import 'package:ip_checker/utils/utils.dart';
import 'package:ip_checker/widgets/card/list_card.dart';
import 'package:ip_checker/widgets/search_bar.dart';
import 'package:ip_checker/utils/sqlite_helper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Device> _devices = [];
  List<Device> _filteredDevices = [];
  final List<StreamSubscription<void>> _subsciptions =
      []; //store streamInput when change page cancel it

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //Notification
    ShowNotification().init();
    //fetch data
    fetchData().then((onValue) {
      //start program
      pingAll(_filteredDevices);
      //schedule ping every 5 minute
      Timer.periodic(
          const Duration(seconds: 20), (Timer t) => pingAll(_filteredDevices));
    });
  }

  @override
  void dispose() {
    for (var subscription in _subsciptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (state == AppLifecycleState.inactive) {
      if (!isRunning) {
        service.startService();
      }
      print("### running");
    } else if (state == AppLifecycleState.detached || state == AppLifecycleState.resumed) {
      if(isRunning){
        service.invoke('stopService');
      }
      pingAll(_filteredDevices);
      print("### Stop running");
    }
  }

  Future<void> pingAll(List<Device> devices) async {
    for (var device in devices) {
      device.type == Type.icmp
          ? await pingWithICMP(device)
          : await pingWithHTTP(device);
    }
  }

  Future<void> pingWithICMP(Device device) async {
    int deviceIdx =
        _filteredDevices.indexWhere((item) => item.name == device.name);
    final ping = Ping(
      device.ip,
      count: 1,
      timeout: 5,
      ipv6: false,
    );
    final subsciption = ping.stream.listen((event) {
      if (!mounted) return;
      if (event.error == null) {
        if (event.response == null) {
          if (event.summary?.received != 0) {
            setState(() => device.setStatus(Status.online));
            ShowNotification().closeNotification(deviceIdx);
          } else {
            setState(() => device.setStatus(Status.offline));
            ShowNotification().showNotification(device, deviceIdx);
          }
        }
      } else {
        setState(() => device.setStatus(Status.offline));
        ShowNotification().showNotification(device, deviceIdx);
      }
    }).asFuture();
    _subsciptions.add(subsciption.asStream().listen((event) {}));
    print("### inApp ${device.name} ${device.status} ${device.lastOffline}");
  }

  Future<void> pingWithHTTP(Device device) async {
    int deviceIdx =
        _filteredDevices.indexWhere((item) => item.name == device.name);
    try {
      http.Response response = await http.get(Uri.parse("https://${device.ip}"),
          headers: {
            "Accept": "application/json"
          }).timeout(const Duration(minutes: 3));
      if (!mounted) return;
      if (response.statusCode != 200) {
        setState(() => device.setStatus(Status.offline));
        ShowNotification().showNotification(device, deviceIdx);
      } else {
        final data = jsonDecode(response.body);
        Duration diff = getDifferenceTime(data['time'] as int);
        if (diff.inSeconds > 60) {
          setState(() => device.setStatus(Status.lowOnline));
        } else {
          setState(() => device.setStatus(Status.online));
        }
        ShowNotification().closeNotification(deviceIdx);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => device.setStatus(Status.offline));
      ShowNotification().showNotification(device, deviceIdx);
    }
    print("### inApp ${device.name} ${device.status} ${device.lastOffline}");
  }

  Future<void> fetchData() async {
    await SQLiteHelper().getDevice().then((deviceList) {
      setState(() {
        _devices = deviceList;
        _filteredDevices = deviceList;
      });
    });
  }

  void updateFilteredDevices(List<Device> devices) {
    setState(() {
      _filteredDevices = devices;
    });
  }

  void deleteDevice(Device device) async {
    setState(() {
      _devices.remove(device);
      _filteredDevices = _devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Device",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text under header My Device
            Container(
              padding: const EdgeInsets.only(left: 5),
              //margin: EdgeInsets.zero,
              width: 400,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Check the condition of the equipment.",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
                  )
                ],
              ),
            ),
            //search bar
            Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: SearchDeviceBar(
                    devices: _devices, callback: updateFilteredDevices)),
            //All device
            _filteredDevices.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsetsDirectional.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListCardDevice(
                        devices: _filteredDevices, deleteDevice: deleteDevice))
                : Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No device",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ]),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(101, 138, 190, 100),
        label: const Text(
          "+",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AddDevice()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
