
import 'package:flutter/material.dart';

const Color ONLINE = Color.fromRGBO(64, 230, 171, 100);
const Color OFFLINE = Color.fromRGBO(206, 68, 68, 100);

class Device {
  String name;
  String ip;
  bool status = false;
  Color colorStatus = Colors.grey;
  bool selected = false;

  Device({required this.name, required this.ip});

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
  Device(name: "Router 1", ip: "10.0.2.2"),
  Device(name: "Router 2", ip: "192.168.1.39"),
  Device(name: "Router 3", ip: "192.168.1.39"),
  Device(name: "Router 4", ip: "192.168.1.39"),
  Device(name: "Router 5", ip: "192.168.1.39"),
];
