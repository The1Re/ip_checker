import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:ip_checker/screens/home.dart';
import 'package:ip_checker/utils/run_background.dart';


void main() async{
  runApp(const MyApp());
  //RunBackground runBackground = RunBackground();
  //runBackground.startBackgroundTask();
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

