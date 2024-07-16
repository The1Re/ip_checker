
import 'package:flutter/material.dart';

const Color ONLINE = Color.fromRGBO(64, 230, 171, 100);
const Color OFFLINE = Color.fromRGBO(206, 68, 68, 100);

class Device {
  String name;
  String ip;
  late DateTime addDate;
  late DateTime lastOffline;
  bool status = false;
  Color colorStatus = Colors.grey;
  bool selected = false;

  Device({required this.name, required this.ip ,required this.addDate});

  void setStatus(bool status) {
    this.status = status;
  }

  void setColorstatus(Color colorStatus) {
    this.colorStatus = colorStatus;
  }

  bool getSelected() {
    return selected;
  }
  String get names => name; 
  void setSelected(bool selected) {
    this.selected = selected;
  }

  void setName(String name){
    this.name = name;
  }

  void setIp(String ip){
    this.ip = ip;
  }
}

List<Device> deviceList = [
  Device(name: "Router 1", ip: "10.0.2.2",addDate:DateTime.now()),
];
