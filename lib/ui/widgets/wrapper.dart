import 'package:driver_app/services/auth.dart';
import 'package:driver_app/ui/widgets/home_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/ui/screens/home/vehicle_selection_page.dart';
import 'package:driver_app/ui/screens/home/home.dart';
import 'authentication.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Home();
   // return FirebaseAuthService.currentFirebaseUser() == null ? const Authentication() :  HomeWrapper() ;
  }
}

