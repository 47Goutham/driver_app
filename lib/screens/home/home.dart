import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
           await FirebaseAuthService.auth.signOut();


         } on Exception catch (e) {
           print('Error in Sign Out');
         }

        },
        child : const Text('Logout'),),



    );
  }
}

