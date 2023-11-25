import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputPage extends StatefulWidget {
  PhoneNumberInputPage({super.key});

  @override
  State<PhoneNumberInputPage> createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+374');

  String? phoneNumberError;
  bool loading = false;

  bool isValidArmenianPhoneNumber(String phoneNumber) {
    // Regular expression for Armenian phone numbers
    RegExp armenianPhoneNumberRegExp = RegExp(r'^\+374\d{8}$');

    return armenianPhoneNumberRegExp.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Enter Phone Number'),
          backgroundColor: Colors.yellow,
          titleTextStyle: const TextStyle(
              color: Colors.black45, fontSize: 20, fontFamily: 'Roboto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
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

                        await FirebaseAuthService.verifyPhoneNumber(
                            phoneNumber: phoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              // Handle verification completed
                              // You are now signed in.
                            },
                            verificationFailed:
                                (FirebaseAuthException exception) {
                              // Handle verification failed

                              setState(() {
                                phoneNumberError = exception.message;
                                loading = false;
                              });
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              print('going to otp page');
                              //navigate to otp page
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              // Handle auto retrieval timeout
                              // _firebaseAuth.setVerificationId(verificationId);
                            });
                      }
                    },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow)),
              child: SizedBox(
                  width: 200,
                  height: 40,
                  child: Center(
                      child: loading
                          ? const LinearProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.black26,
                            )
                          : const Text('Send OTP',
                              style: TextStyle(color: Colors.black45)))),
            ),
          ],
        ),
      ),
    );
  }
}
