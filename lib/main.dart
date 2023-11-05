import 'package:driver_app/screens/authenticate/signIn.dart';
import 'package:driver_app/screens/home/home.dart';
import 'package:driver_app/screens/loading.dart';
import 'package:driver_app/services/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService _authService = AuthService();


  @override
  void initState() {
    super.initState();
  }

  Future<User?> _reloadUserData() async {
    User? user = _authService.auth.currentUser;

    if (user != null) {
      try {
        await user.reload();
      } on Exception {
        print('user reload failed');
        user = null;
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Driver App',
        home: StreamBuilder<User?>(
            stream: _authService.auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return FutureBuilder(
                  future: _reloadUserData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        print('has error');
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else {
                        final User? user = snapshot.data;
                        return user == null ? const SignIn() : const Home();
                      }
                    }

                    return const Loading();
                  },
                );
              }
              return const Loading();
            }));
  }
}
