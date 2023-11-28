import 'package:driver_app/services/auth.dart';
import 'package:driver_app/ui/widgets/home_wrapper.dart';
import 'package:flutter/material.dart';
import '../screens/home/company_selection_page.dart';
import 'authentication.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return CompanySelectionPage();
  //  return FirebaseAuthService.currentFirebaseUser() == null ? const Authentication() :  const HomeWrapper() ;
  }
}

