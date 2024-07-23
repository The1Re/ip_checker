import 'dart:convert';
import 'package:flutter/material.dart';

enum Type {
  icmp,
  http
}

enum Status {
  online,
  offline,
  lowOnline,
  unknow
}

extension StatusTypeExtension on Status {
  Color get color {
    switch (this) {
      case Status.online:
        return const Color.fromRGBO(64, 230, 171, 100);
      case Status.offline:
        return const Color.fromRGBO(206, 68, 68, 100);
      case Status.lowOnline:
        return const Color.fromRGBO(235, 179, 105, 100);
      default:
        return Colors.grey;
    }
  }
}
class Device {
  String name;
  String ip;
  DateTime dateAdd;
  DateTime lastOffline;
  Type type;
  Status status;

  void setStatus(Status status) {
    this.status = status;
    if (status == Status.offline) {
      lastOffline = DateTime.now(); //fix should update to database
    }
  }

  Device({
    required this.name,
    required this.ip,
    required this.dateAdd,
    required this.lastOffline,
    this.type = Type.icmp,
    this.status = Status.unknow
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'ip': ip,
      'dateAdd': dateAdd.toIso8601String(),
      'lastOffline': lastOffline.toIso8601String(),
      'status': status.name,
      'type': type.name
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      name: map['name'],
      ip: map['ip'],
      dateAdd: DateTime.parse(map['dateAdd']),
      lastOffline: DateTime.parse(map['lastOffline']),
      status: Status.values.byName(map['status']),
      type: Type.values.byName(map['type'])
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() {
    return """Device(
      name: $name, 
      ip: $ip, 
      dateAdd: $dateAdd, 
      lastOffline: $lastOffline,
      status: $status,
      type: $type
      """;
  }

}


