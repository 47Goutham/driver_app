import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInPhone(String phone, Function(PhoneAuthCredential) verificationCompleted, Function(FirebaseAuthException) verificationFailed, Function(String,int?) codeSent, Function(String) codeAutoRetrievalTimeout) async {

       await   _auth.verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          );
  }


  // void signInWithCredential(String smsCode){
  //
  //   // Create a PhoneAuthCredential with the code
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode);
  //
  //   // Sign the user in (or link) with the credential
  //   await authApi.signInWithCredential(credential);
  // }

}

