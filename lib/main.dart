import 'dart:async';
import 'package:flutter/material.dart';
import 'UI/screens/splash_page.dart';

Future<void> main() async {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(useMaterial3: true),
      home: const SplashScreen()));
}
