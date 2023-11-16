import 'package:driver_app/screens/authenticate/error.dart';
import 'package:driver_app/screens/authenticate/userNameInputPage.dart';
import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTPInputPage extends StatefulWidget {
  final String verificationId;


  const OTPInputPage({super.key, required this.verificationId});



  @override
  OTPInputPageState createState() => OTPInputPageState();
}

class OTPInputPageState extends State<OTPInputPage> {

  bool loading = false;
  bool error = false;

  Future<String> signInWithOTP(String otp, String verificationId)  async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential  UserCredential firebaseUser =
    try {
      UserCredential user =  await  FirebaseAuthService.auth.signInWithCredential(credential);

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
        title: Text('Enter OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: PinCodeTextField(
                appContext: context,
                enabled: !loading,
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
                  setState(() {
                    loading = true ;
                  });


                  signInWithOTP(otp,widget.verificationId).then((value)  {
                    if(value == 'success') {

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                              builder: (context) => UserNameInputPage()
                          )
                      );
                    }else if(value == 'reenterOTP') {

                      setState(() {
                        loading = false;
                        error = true ;
                      });
                    }

                    else {
                      Navigator.pushReplacement(
                          context,
                        MaterialPageRoute(
                          builder: (context) => ErrorMassage(error: value) )
                        );

                    }
                  }) ;


                },
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 40,
                width: 200,
                child: loading ? Center(child: LinearProgressIndicator(color: Colors.black,backgroundColor: Colors.black26,)) : (error ? Center(child: Text('Invalid OTP',style: TextStyle(color: Colors.red),)) : null)
            ),

          ],
        ),
      ),
    );
  }
}