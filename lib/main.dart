import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:ip_checker/screens/Home.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
