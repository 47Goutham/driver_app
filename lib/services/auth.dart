import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> updateName(String name) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      return Future.error('Error: ${e.message}');
    }
  }

  static Future<String> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
      return 'success';
    } on FirebaseAuthException catch (e) {
      return Future.error('Error: ${e.message}');
    }
  }

  static User? currentFirebaseUser() {
    return _auth.currentUser;
  }

  static void verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout}) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static Future<String> signInWithOTP({required String verificationId, required String otp}) async {
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign the user in (or link) with the credential
      await _auth.signInWithCredential(credential);

      // If signInWithCredential is successful, return 'success'
      return 'success';
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      switch (e.code) {
        case 'invalid-verification-code':
        case 'invalid-verification-id':
          // Return 'reenterOTP' for these specific error codes
          return 'reenterOTP';
        default:
          // For other error codes, return the error message
          return '${e.message}';
      }
    }
  }
}
