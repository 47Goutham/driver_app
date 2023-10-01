import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/services/functions.dart';
import 'package:driver_app/screens/loading.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String? phoneNumberError, smsError;
  String phoneNumber = '+374';
  bool loading = false;
  bool smsBox = false;
  String? smsValue;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final inputCompleter = Completer<void>();


  void verifyPhoneNumber()  {
   _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {
      // Handle verification completed
      // You are now signed in.
    },
    verificationFailed: (FirebaseAuthException exception) {
      // Handle verification failed
      print('Phone verification failed: ${exception.message}');
    },
    codeSent:  (String verificationId, int? resendToken) async {
      // Update the UI - wait for the user to enter the SMS code

      setState(() {
        loading = false;
        smsBox = true;
      });

      await waitForUserSMSCodeInput();

      print(smsValue);
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsValue!);

      // Sign the user in (or link) with the credential
     final user =  await _auth.signInWithCredential(credential);
    print(user);

    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Handle auto retrieval timeout
      // _firebaseAuth.setVerificationId(verificationId);
    },
  );
}

  Future<void> waitForUserSMSCodeInput() async {
    await inputCompleter.future;
  }


  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign In',
                style: TextStyle(color: Colors.black45),
              ),
              backgroundColor: Colors.yellow[200],
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    smsBox
                        ? TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: InputDecoration(
                              hintText: 'Enter SMS Code',
                              border: const OutlineInputBorder(),
                              errorText: smsError,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'SMS Code is required';
                              } else if (value.length != 6) {
                                return 'Enter a valid 6-digit code';
                              }
                              return null; // Return null if the validation is successful
                            },
                            onChanged: (value) {
                              smsValue = value;
                            },
                          )
                        : TextFormField(
                            initialValue: phoneNumber,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Phone Number',
                              errorText: phoneNumberError,
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '+374') {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.yellow),
                        minimumSize: MaterialStatePropertyAll(
                          Size(100, 30),
                        ),
                      ),
                      onPressed: () async {
                        final value = _formKey.currentState?.validate();
                        if (value == true) {
                          setState(() {
                            loading = true;
                          });
                          if (!smsBox) {
                            final result = await Functions()
                                .checkPhoneNumberExists(phoneNumber);
                            if (result == 'error' ||
                                result == 'Phone number not registered') {
                              setState(() {
                                phoneNumberError = result;
                                loading = false;
                              });
                            } else {
                              // Perform login
                               verifyPhoneNumber();
                            }
                          } else {
                            inputCompleter.complete();
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black45),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }


}
