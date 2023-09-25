import 'package:flutter/material.dart';

import 'package:driver_app/services/functions.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String? phoneNumberError;
  String phoneNumber = '+374';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
              TextFormField(
                initialValue: phoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.yellow),
                  minimumSize: MaterialStatePropertyAll(
                    Size(100, 30),
                  ),
                ),

                onPressed: () async {
                  final value = _formKey.currentState?.validate();
                  if (value == true) {
                    final result = await Functions().checkPhoneNumberExists(phoneNumber);
                    print(result);
                    if (result == 'error' || result == 'Phone number not registered') {
                      setState(() {
                        phoneNumberError = result;
                      });
                    } else {
                      setState(() {
                        phoneNumberError = null;
                      });
                      // Perform login
                    }
                  }
                },
                child: Text(
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
