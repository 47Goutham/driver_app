import 'package:driver_app/screens/authenticate/error.dart';
import 'package:driver_app/screens/authenticate/phoneNumberInputScreen.dart';
import 'package:driver_app/screens/authenticate/signIn.dart';
import 'package:driver_app/screens/home/home.dart';
import 'package:driver_app/screens/loading.dart';
import 'package:driver_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<AuthUser>(
      stream: FirebaseAuthService.firebaseUserStream,

      builder: (context, snapshot) {
        bool loading = false;
        User? user;

        switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              // Handle case when there is no connection // Handle case when the data is still loading
                   loading = true ;
              case ConnectionState.active:
              case ConnectionState.done:
                    // Handle case when data is available
                  user = snapshot.data?.user;

        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Driver App',
          home: snapshot.data?.error != null ? ErrorMassage(error : snapshot.data?.error) :  (loading ? const Loading() :  (user == null ? const PhoneNumberInputPage() : const Home()))
        );
      },
    );
  }
}

