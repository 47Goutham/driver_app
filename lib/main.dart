import 'dart:async';
import 'package:driver_app/UI/screens/home/company_selection_page.dart';
import 'package:driver_app/UI/screens/home/rr_account_selection_page.dart';
import 'package:driver_app/models/user.dart';
import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/screens/splash_page.dart';
import 'firebase_options.dart';

void main() async {

  runApp( MyApp() );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return UserDataInheritedWidget(
      userData: UserData(),
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          //theme: ThemeData(useMaterial3: true),
         home: SplashScreen()),


    );
  }
}



