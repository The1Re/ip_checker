
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';


const Color ONLINE = Color.fromRGBO(64, 230, 171, 100);
const Color OFFLINE = Color.fromRGBO(206, 68, 68, 100);
const Color LOW_ONLINE = Color.fromRGBO(235 , 179, 105, 100);

enum TYPE {
  icmp,
  http
}

class Device {
  String name;
  String ip;
  //String type;
  bool status;
  DateTime dateAdd;
  DateTime lastOffline;

  TYPE type;

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

  Device({
    required this.name,
    required this.ip,
    required this.status,
    required this.dateAdd,
    required this.lastOffline,
    this.type = TYPE.icmp
  });

  Device copyWith({
    String? name,
    String? ip,
    bool? status,
    DateTime? dateAdd,
    DateTime? lastOffline,
  }) {
    return Device(
      name: name ?? this.name, 
      ip: ip ?? this.ip, 
      status: status ?? this.status, 
      dateAdd: dateAdd ?? this.dateAdd, 
      lastOffline: lastOffline ?? this.lastOffline
    );
  }
  Map<String, Object?> toMap() {
    int st = (status == true)? 1 : 0;
    return {
      'name': name,
      'ip': ip,
      'status': st,
      'dateAdd': dateAdd.toIso8601String(),
      'lastOffline': lastOffline.toIso8601String(),
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    bool st = (map['status'] == 1 )? true : false;
    return Device(
      name: map['name'],
      ip: map['ip'],
      status: st,
      dateAdd: DateTime.parse(map['dateAdd']),
      lastOffline: DateTime.parse(map['lastOffline']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() {
    return """Device(
      name: $name, 
      ip: $ip, 
      status: $status, 
      dateAdd: $dateAdd, 
      lastOffline: $lastOffline, """;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Device &&
      other.name == name &&
      other.ip == ip &&
      other.status == status &&
      other.dateAdd == dateAdd  &&
      other.lastOffline == lastOffline;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      ip.hashCode ^
      status.hashCode ^
      dateAdd.hashCode ^
      lastOffline.hashCode;
  }
}


