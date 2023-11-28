import 'package:driver_app/services/auth.dart';
import 'package:flutter/material.dart';


class AccountSelectionPage extends StatelessWidget {
  const AccountSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Yandex Account'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
        actions: [Image.asset('assets/images/logo.png')],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(Size(300, 80))),
                  child: Text(
                    'Own Account:${FirebaseAuthService.currentFirebaseUser()?.phoneNumber}',
                    style: TextStyle(color: Colors.black54,fontSize: 25 ,fontWeight: FontWeight.w400),
                  )),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(Size(300, 80))),
                  child: Text('Other\'s Account', style: TextStyle(color: Colors.black54,fontSize: 25,fontWeight: FontWeight.w400))),

              SizedBox(height: 30,),
              TextFormField(
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
              SizedBox(height: 30,),
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
                      : null))

            ],
          ))
    );
  }
}
