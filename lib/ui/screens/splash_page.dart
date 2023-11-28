import 'package:driver_app/UI/screens/error_page.dart';
import 'package:driver_app/UI/widgets/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../firebase_options.dart';
import '../../services/auth.dart';
import 'authenticate/phone_number_input_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 500, end: 300).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    WidgetsFlutterBinding.ensureInitialized();

    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((_) {
      Future.wait([
        FirebaseAuthService.reloadUser(),
        Future.delayed(const Duration(seconds: 3))
      ]).then((_) {
        //NAVIGATE TO NEXT SCREEN
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return FadeTransition(
                  opacity: animation,
                  child: Wrapper()
              );
            },
            transitionDuration: Duration(seconds: 1,milliseconds: 500), // Increase the duration to slow down the animation
          ),
        );
      }).catchError((error) {
        //NAVIGATE TO ERROR SCREEN
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorMassage(error: error),
          ),
        );
      });
    }).catchError((error) {
      //NAVIGATE TO ERROR SCREEN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorMassage(error: error),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Center(child: Container(
            margin: EdgeInsets.symmetric(vertical: _animation.value),
            child:
            Hero(
              tag: 'hero_logo',
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
