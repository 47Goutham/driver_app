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
  String? phoneNumberError;
  String phoneNumber = '+374';
  bool loading = false;

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
                    final result = await Functions().checkPhoneNumberExists(phoneNumber);
                    if (result == 'error' || result == 'Phone number not registered') {
                      setState(() {
                        phoneNumberError = result;
                        loading = false;
                      });
                    } else {
                      setState(() {
                        phoneNumberError = null;
                        loading = false;
                      });
                      // Perform login
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
