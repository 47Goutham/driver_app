import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService  {
  static final FirebaseAuth _auth = FirebaseAuth.instance;



 static Future<String> updateName (String name) async {
   try {
     await _auth.currentUser?.updateDisplayName(name);
     return 'success';
   } on FirebaseAuthException catch (e) {
     return Future.error('Error: ${e.message}');
   }
  }

  static Future<String> reloadUser()   async {
   try {
     await _auth.currentUser?.reload();
     return 'success';
   } on FirebaseAuthException catch (e) {
     return Future.error('Error: ${e.message}');
   }
 }

 static User? currentFirebaseUser(){
   return _auth.currentUser ;
 }

 static Future<void> verifyPhoneNumber({required String phoneNumber,required void Function(PhoneAuthCredential) verificationCompleted,required void Function(FirebaseAuthException) verificationFailed,required void Function(String, int?) codeSent,required void Function(String) codeAutoRetrievalTimeout })async {

   await  _auth.verifyPhoneNumber(verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

 }

}
