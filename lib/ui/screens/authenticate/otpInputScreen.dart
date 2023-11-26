import 'package:driver_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../error.dart';

class OTPInputPage extends StatefulWidget {
  final String verificationId;
  const OTPInputPage({super.key, required this.verificationId});

  @override
  State<OTPInputPage> createState() => _OTPInputPageState();
}

class _OTPInputPageState extends State<OTPInputPage> {
  bool otpLoading = false;
  bool otpError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(
            color: Colors.black45, fontSize: 20, fontFamily: 'Roboto'),
        actions: [Image.asset('assets/images/logo.png')],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinCodeTextField(
                appContext: context,
                enabled: !otpLoading,
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                onCompleted: (otp) {
                  otpLoading = true;

                  FirebaseAuthService.signInWithOTP(
                          verificationId: widget.verificationId, otp: otp)
                      .then((result) {
                    if (result == 'success') {
                      //NAVIGATE TO USERNAMEINPUTPAGE


                    } else if (result == 'reenterOTP') {
                      otpLoading = false;
                      otpError = true;
                    } else {

                      //NAVIGATE TO ERROR PAGE
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ErrorMassage(error: result),
                        ),
                      );
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 40,
                width: 200,
                child: otpLoading
                    ? const Center(
                        child: LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.black26,
                      ))
                    : (otpError
                        ? const Center(
                            child: Text(
                            'Invalid OTP',
                            style: TextStyle(color: Colors.red),
                          ))
                        : null)),
          ],
        ),
      ),
    );
  }
}
