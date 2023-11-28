import 'dart:async';
import 'package:flutter/material.dart';
import 'UI/screens/splash_page.dart';

Future<void> main() async {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(child: SplashScreen())));
}
