
import 'package:flutter/material.dart';

class Device {
  Device({required this.nameDeivce, required this.ip});
  String nameDeivce;
  String ip;
  bool status = false;
  Color online = Color.fromRGBO(64, 230, 171, 100);
  Color offline = Color.fromRGBO(206, 68, 68, 100);
  Color colorStatus = Colors.grey;
  bool selected = false;

  void setStatus(bool s) {
    status = s;
  }

  void setColorstatus(Color cs) {
    colorStatus = cs;
  }

  bool getSelected() {
    return selected;
  }

  void setSelected(bool sel) {
    selected = sel;
  }
}

List<Device> data = [
  Device(nameDeivce: "Router 1", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 2", ip: "google.com"),
  Device(nameDeivce: "Router 3", ip: "youtube.com"),
  Device(nameDeivce: "Router 1", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 2", ip: "google.com"),
  Device(nameDeivce: "Router 3", ip: "youtube.com"),
];
