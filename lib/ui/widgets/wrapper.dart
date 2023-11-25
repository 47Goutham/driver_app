import 'package:driver_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';
import 'home.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});


  @override
  Widget build(BuildContext context) {
    final firebaseUser =  FirebaseAuthService.currentFirebaseUser();
    return firebaseUser == null ? Authentication() : Home() ;
  }
}
