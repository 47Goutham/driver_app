import 'package:driver_app/screens/authenticate/error.dart';
import 'package:driver_app/screens/authenticate/userNameInputPage.dart';
import 'package:driver_app/services/auth.dart';
import 'package:driver_app/services/pageController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class OTPInputPage extends StatelessWidget {

    final String verificationId;
    OTPInputPage({super.key, required this.verificationId});
    final MyController myController = Get.find<MyController>() ;

      Future<String> signInWithOTP(String otp, String verificationId)  async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential  UserCredential firebaseUser =
    try {
       await  FirebaseAuthController.auth.signInWithCredential(credential);

       return 'success';


    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'invalid-verification-code':
        case 'invalid-verification-id':
           return 'reenterOTP';
      }
      return '${e.message}';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(color: Colors.black45,fontSize: 20,fontFamily: 'Roboto')
      ),
      body: Obx(()=>Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinCodeTextField(
                appContext: context,
                enabled: !myController.otpLoading.value,
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),

                onCompleted: (otp){

                  myController.otpLoading.value = true ;



                  signInWithOTP(otp,verificationId).then((value)  {
                    if(value == 'success') {

                      Get.off(
                          () => UserNameInputPage(),
                          transition: Transition.rightToLeft
                      );

                    }else if(value == 'reenterOTP') {

                      myController.otpLoading.value = false;
                      myController.otpError.value = true ;
                    }

                    else {
                      Get.off(ErrorMassage(error: value));
                    }
                  }) ;


                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 40,
                width: 200,
                child: myController.otpLoading.value ? const Center(child: LinearProgressIndicator(color: Colors.black,backgroundColor: Colors.black26,)) : (myController.otpError.value ? const Center(child: Text('Invalid OTP',style: TextStyle(color: Colors.red),)) : null)
            ),

          ],
        ),
      )),
    );
  }
}


