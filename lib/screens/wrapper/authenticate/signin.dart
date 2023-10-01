import 'package:driver_app/services/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/services/functions.dart';
import 'package:driver_app/screens/loading.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String? phoneNumberError;
  String phoneNumber = '+374';
  bool loading = false;
  bool smsBox = true;
  String? smsValue;
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());



  // AuthService authApi =  AuthService();


  void _verifyPhoneNumber() {
    // authApi.signInPhone(
    //   phoneNumber,
    //       (PhoneAuthCredential credential) {
    //     // Handle verification completed
    //     // You are now signed in.
    //   },
    //       (FirebaseAuthException exception) {
    //     // Handle verification failed
    //     print('Phone verification failed: ${exception.message}');
    //   },
    //         (String verificationId, int? resendToken) async {
    //       // Update the UI - wait for the user to enter the SMS code
    //
    //           setState(() {
    //             loading = false;
    //             smsBox = true;
    //           });
    //
    //    },
    //
    //       (String verificationId) {
    //     // Handle auto retrieval timeout
    //    // _firebaseAuth.setVerificationId(verificationId);
    //   },
    // );
  }







  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
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
              smsBox ?
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },


                  ),
                ),
              ),
          )
                  :
              TextFormField(
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
                  if (value == null || value.isEmpty || value == '+374') {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.yellow),
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
                    if(!smsBox){
                      final result = await Functions().checkPhoneNumberExists(phoneNumber);
                      if (result == 'error' || result == 'Phone number not registered') {
                        setState(() {
                          phoneNumberError = result;
                          loading = false;
                        });
                      } else {
                        // Perform login
                        _verifyPhoneNumber();
                      }
                    }else {

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
