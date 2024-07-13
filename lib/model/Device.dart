import 'dart:ffi';

import 'package:flutter/material.dart';

class Device {
  Device({required this.nameDeivce,required this.ip,required this.status});
  String nameDeivce;
  String ip;
  bool status;
  Color online = Color.fromRGBO(64, 230, 171, 100);
  Color offline = Color.fromRGBO(206, 68, 68, 100);
  Color colorStatus = Colors.grey;

  void setStatus(bool s){
    status = s;
  }

  void setColorstatus(Color cs){
    colorStatus = cs;
  }
}



List<Device> data =[
  Device(nameDeivce: "Router 1", ip: "192.168.1.39", status: true),
  Device(nameDeivce: "Router 2", ip: "google.com", status: true),
  Device(nameDeivce: "Router 3", ip: "youtube.com", status: false),
];