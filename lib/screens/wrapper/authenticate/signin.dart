import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
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
                initialValue: '+374',
                validator: (value) {
                  if (value == null || value.isEmpty || value == '+374') {
                    return 'Please enter phone number';
                  }
                  else{

                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone

              ),

              SizedBox(height: 10),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.yellow),
                      minimumSize: MaterialStatePropertyAll(
                        Size(100, 30),
                      )
                  ),
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black45),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
