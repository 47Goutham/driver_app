import 'package:driver_app/services/auth.dart';
import 'package:driver_app/ui/screens/home/user_name_input_page.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../error_page.dart';

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
            color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
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
                  setState(() {
                    otpLoading = true;
                  });

                  FirebaseAuthService.signInWithOTP(
                          verificationId: widget.verificationId, otp: otp)
                      .then((result) {
                    if (result == 'success') {



                      //NAVIGATE TO USERNAMEINPUTPAGE
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder<void>(
                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                            const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                            const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                            var tween = Tween(begin: begin, end: end);

                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                                position: offsetAnimation,
                                child: UserNameInputPage()
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500), // Increase the duration to slow down the animation
                        ),
                       (Route<dynamic> route) => false
                      );

                    } else if (result == 'reenterOTP') {
                      setState(() {
                        otpLoading = false;
                        otpError = true;
                      });
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
