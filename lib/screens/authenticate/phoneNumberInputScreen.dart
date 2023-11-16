import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpInputScreen.dart';

class PhoneNumberInputPage extends StatefulWidget {
  const PhoneNumberInputPage({super.key});

  @override
  PhoneNumberInputPageState createState() => PhoneNumberInputPageState();
}

class PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+374');

  String phoneNumber = '';
  String? phoneNumberError;
  bool loading = false;

  bool isValidArmenianPhoneNumber(String phoneNumber) {
    // Regular expression for Armenian phone numbers
    RegExp armenianPhoneNumberRegExp = RegExp(r'^\+374\d{8}$');

    return armenianPhoneNumberRegExp.hasMatch(phoneNumber);
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    await FirebaseAuthService.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle verification completed
          // You are now signed in.
        },
        verificationFailed: (FirebaseAuthException exception) {
          // Handle verification failed

          setState(() {
            phoneNumberError = exception.message ;
            loading = false;
          });


        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(

              builder: (context) => OTPInputPage(verificationId: verificationId ),

            ),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  errorText: phoneNumberError,
                ),
                readOnly: loading,
              ),
            ),
            ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        final phoneNumber = phoneNumberController.text.trim();

                        if (phoneNumber.isEmpty || phoneNumber == '+374') {
                          setState(() {
                            phoneNumberError = 'Please enter phone number';
                          });
                        } else if (!isValidArmenianPhoneNumber(phoneNumber)) {
                          setState(() {
                            phoneNumberError = 'Invalid Armenian Number';
                          });
                        } else {
                          setState(() {
                            phoneNumberError = null;
                            loading = true;
                          });

                          await verifyPhoneNumber(phoneNumber, context);
                        }
                      },
                child: Container(
                    width: 200,
                    height: 40,
                    child: loading
                        ? Center(
                            child: LinearProgressIndicator(
                            color: Colors.black,
                            backgroundColor: Colors.black26,
                          ))
                        : Center(child: Text('Send OTP')))),

          ],
        ),
      ),
    );
  }
}




