import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ip_checker/screens/home.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:ip_checker/utils/run_background.dart';
import 'package:ip_checker/utils/show_notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  HttpOverrides.global = MyHttpOverride();
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

