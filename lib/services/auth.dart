import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final User? user;
  final String? error;
  AuthUser({this.user,this.error});
}


class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;


  static Stream<AuthUser> firebaseUserStream = FirebaseAuth.instance
      .authStateChanges().asyncMap((User? user) async {
    if (user != null) {
      try {
        await user.reload();
        } on FirebaseAuthException catch (e) {
            return AuthUser(error: e.message);
      }
      return AuthUser(user: user);
    }
    return AuthUser(user: user);
  });

}

