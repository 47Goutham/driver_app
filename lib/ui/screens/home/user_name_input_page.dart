import 'package:driver_app/services/auth.dart';
import 'package:driver_app/ui/screens/home/home.dart';
import 'package:driver_app/ui/widgets/home_wrapper.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';

class UserNameInputPage extends StatefulWidget {
  const UserNameInputPage({super.key});

  @override
  State<UserNameInputPage> createState() => _UserNameInputPageState();
}

class _UserNameInputPageState extends State<UserNameInputPage> {
  String? displayName = FirebaseAuthService.currentFirebaseUser()?.displayName;
  final TextEditingController userNameController = TextEditingController();
  String? userNameError;
  bool userNameLoading = false;

  @override
  void initState() {
    super.initState();
    userNameController.text = displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enter Your Name'),
          backgroundColor: Colors.yellow,
          titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
          actions: [
            Hero(tag: 'hero_logo',
            child: Image.asset('assets/images/logo.png'))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Name',
                    errorText: userNameError,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                  if (userNameController.text.trim() == '') {
                    setState(() {
                      userNameError = '';
                    });
                  } else {
                    String result;
                    if (displayName != userNameController.text.trim()) {
                      setState(() {
                        userNameLoading = true;
                      });

                      FirebaseAuthService.updateName(userNameController.text.trim()).then((_) {
                          //navigate to  home
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder<void>(
                            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                              const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                              const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                              var tween = Tween(begin: begin, end: end);

                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation,
                                  child: HomeWrapper()
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500), // Increase the duration to slow down the animation
                          ),
                        );
                      }).catchError((e){
                         //navigate to error
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ErrorMassage(error: e),
                          ),
                        );
                      });

                    } else {
                       //navigate to home
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder<void>(
                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                            const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                            const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                            var tween = Tween(begin: begin, end: end);

                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                                position: offsetAnimation,
                                child: HomeWrapper()
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500), // Increase the duration to slow down the animation
                        ),
                      );
                    }


                  }
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                child: SizedBox(
                    width: 200,
                    height: 40,
                    child: Center(
                        child: userNameLoading
                            ? LinearProgressIndicator(
                                color: Colors.black,
                                backgroundColor: Colors.black26,
                              )
                            : const Text('Submit', style: TextStyle(color: Colors.black45)))),
              ),
            ],
          ),
        ));
  }
}
