import 'package:driver_app/main.dart';
import 'package:driver_app/screens/authenticate/phoneNumberInputScreen.dart';
import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Text('home'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         try {
           await FirebaseAuthController.auth.signOut();
           Get.off(() =>PhoneNumberInputPage());

         } on Exception catch (e) {
           print('Error in Sign Out');
         }

        },
        child : const Text('Logout'),),



    );
  }
}

