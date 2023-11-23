import 'package:driver_app/services/auth.dart';
import 'package:driver_app/services/pageController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otpInputScreen.dart';

class PhoneNumberInputPage extends StatelessWidget {
   PhoneNumberInputPage({super.key});

    final TextEditingController phoneNumberController =  TextEditingController(text: '+374');

  final MyController myController = Get.find<MyController>();

     bool isValidArmenianPhoneNumber(String phoneNumber) {
    // Regular expression for Armenian phone numbers
    RegExp armenianPhoneNumberRegExp = RegExp(r'^\+374\d{8}$');

    return armenianPhoneNumberRegExp.hasMatch(phoneNumber);
  }


     Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    await FirebaseAuthController.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle verification completed
          // You are now signed in.
        },
        verificationFailed: (FirebaseAuthException exception) {
          // Handle verification failed

            myController.phoneNumberError.value = exception.message! ;
            myController.loading.value = false;



        },
        codeSent: (String verificationId, int? resendToken) {

          Get.off(
              () => OTPInputPage(verificationId: verificationId ),
             transition: Transition.rightToLeft,

          );


          },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto retrieval timeout
          // _firebaseAuth.setVerificationId(verificationId);
        });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(color: Colors.black45,fontSize: 20,fontFamily: 'Roboto')
      ),
      body: Obx(() =>Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  errorText: myController.phoneNumberError.value,
                ),
                readOnly: myController.loading.value,
              ),
            ),
            ElevatedButton(
                onPressed: myController.loading.value
                    ? null
                    : () async {
                  final phoneNumber = phoneNumberController.text.trim();

                  if (phoneNumber.isEmpty || phoneNumber == '+374') {

                    myController.phoneNumberError.value = 'Please enter phone number';

                  } else if (!isValidArmenianPhoneNumber(phoneNumber)) {

                    myController.phoneNumberError.value = 'Invalid Armenian Number';

                  } else {

                    myController.phoneNumberError.value = null;
                    myController.loading.value = true;


                    await verifyPhoneNumber(phoneNumber, context);
                  }
                },
                child: SizedBox(
                    width: 200,
                    height: 40,

                    child: Center(child: myController.loading.value
                        ?  LinearProgressIndicator(
                          color: Colors.black,
                          backgroundColor: Colors.black26,
                        )
                        : const Text('Send OTP',style: TextStyle(color: Colors.black45)))),
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.yellow)),
            ),

          ],
        ),
      )),
    );



  }
}


