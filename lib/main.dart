import 'dart:async';


import 'package:driver_app/UI/widgets/wrapper.dart';
import 'package:driver_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UI/screens/error.dart';
import 'UI/screens/splashscreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FutureBuilder(future: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      await Future.wait([
        FirebaseAuthService.reloadUser(),
        Future.delayed(const Duration(seconds: 4))
      ]);
    }(), builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const SplashScreen();
      } else {
        if (snapshot.hasError) {
          return ErrorMassage(error: snapshot.error.toString());
        } else {
          return const Wrapper();
        }
      }
    }),
  ));


}


