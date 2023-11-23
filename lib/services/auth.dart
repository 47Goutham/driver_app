import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  Future<String> updateName (String name) async {
   try {
     await auth.currentUser?.updateDisplayName(name);
     return 'success';
   } on FirebaseAuthException catch (e) {
     return 'error: ${e.message}';
   }
  }

}
