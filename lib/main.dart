import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:driver_app/screens/authenticate/error.dart';
import 'package:driver_app/screens/authenticate/phoneNumberInputScreen.dart';
import 'package:driver_app/screens/authenticate/signIn.dart';
import 'package:driver_app/screens/home/home.dart';
import 'package:driver_app/screens/loading.dart';
import 'package:driver_app/screens/splashscreen.dart';
import 'package:driver_app/services/auth.dart';
import 'package:driver_app/services/pageController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';


import 'firebase_options.dart';

Future<void> main() async {

  runApp(const SplashScreen());
  await Future.delayed(const Duration(seconds: 2));
  WidgetsFlutterBinding.ensureInitialized();

      await  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

      Get.put(FirebaseAuthController());
      Get.put(MyController());



   runApp(const Wrapper());

}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
     debugShowCheckedModeBanner: false,
     home: Obx(() => Get.find<FirebaseAuthController>().firebaseUser.value == null ? PhoneNumberInputPage() : const Home())
   ) ;
  }
}


