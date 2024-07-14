
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

  void setStatus(bool status) {
    this.status = status;
  }

  void setColorstatus(Color colorStatus) {
    this.colorStatus = colorStatus;
  }

  bool getSelected() {
    return selected;
  }

  void setSelected(bool selected) {
    this.selected = selected;
  }
}

List<Device> deviceList = [
  Device(nameDeivce: "Router 1", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 2", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 3", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 4", ip: "192.168.1.39"),
  Device(nameDeivce: "Router 5", ip: "192.168.1.39"),
];
