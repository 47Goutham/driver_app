import 'package:driver_app/services/auth.dart';
import 'package:driver_app/ui/screens/home/user_name_input_page.dart';
import 'package:flutter/material.dart';

import '../screens/home/company_selection_page.dart';


class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuthService.currentFirebaseUser()!.displayName == null ? UserNameInputPage() : CompanySelectionPage()  ;
  }
}
