import 'package:driver_app/services/auth.dart';
import 'package:driver_app/services/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';

import 'home.dart';


class AccountSelectionPage extends StatefulWidget {
  const AccountSelectionPage({super.key});

  @override
  State<AccountSelectionPage> createState() => _AccountSelectionPageState();
}

class _AccountSelectionPageState extends State<AccountSelectionPage> {
  final TextEditingController phoneNumberController = TextEditingController(text: FirebaseAuthService.currentFirebaseUser()?.phoneNumber);

  String? phoneNumberError;
  bool loading = false;
  List<bool> selected = [true, false];

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
            ToggleButtons(
              onPressed: loading
                  ? null
                  : (button) {
                      switch (button) {
                        case 0:
                          setState(() {
                            phoneNumberController.text = (FirebaseAuthService.currentFirebaseUser()!.phoneNumber)!;
                            selected[0] = true;
                            selected[1] = false;
                            phoneNumberError = null;
                          });

                        case 1:
                          setState(() {
                            phoneNumberController.text = '+374';
                            selected[0] = false;
                            selected[1] = true;
                            phoneNumberError = null;
                          });
                      }
                    },
              direction: Axis.horizontal,
              isSelected: selected,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.yellow,
              selectedColor: Colors.yellow[100],
              fillColor: Colors.yellow,
              color: Colors.green,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Own Account',
                    style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Other\'s Account',
                    style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  errorText: phoneNumberError,
                ),
                readOnly: loading || selected[0],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: loading
                    ? null
                    : ()  {
                        final phoneNumber = phoneNumberController.text.trim();

                        if (phoneNumber.isEmpty || phoneNumber == '+374') {
                          setState(() {
                            phoneNumberError = 'Please enter phone number';
                          });
                        } else if (!HelperFunctions.isValidArmenianPhoneNumber(phoneNumber)) {
                          setState(() {
                            phoneNumberError = 'Invalid Armenian Number';
                          });
                        } else if (phoneNumber == FirebaseAuthService.currentFirebaseUser()!.phoneNumber && selected[1] == true) {
                          setState(() {
                            phoneNumberError = 'This is your Own Account number';
                          });
                        } else {
                          setState(() {
                            phoneNumberError = null;
                            loading = true;
                          });



                          HelperFunctions.checkPhoneNumberExists(phoneNumber, UserDataInheritedWidget.of(context).userData).then((val) {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder<void>(
                                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                  const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                                  const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                                  var tween = Tween(begin: begin, end: end);

                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: const Home());
                                },
                                transitionDuration: const Duration(milliseconds: 500), // Increase the duration to slow down the animation
                              ),
                            );
                          }).catchError((err) {
                            setState(() {
                              phoneNumberError = err;
                              loading = false;
                            });
                          });
                        }
                      },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                child: SizedBox(
                  height: 40,
                  width: 200,
                  child: Center(
                    child: loading
                        ? const LinearProgressIndicator(
                            color: Colors.black,
                            backgroundColor: Colors.black26,
                          )
                        : const Text('Next', style: TextStyle(color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w400)),
                  ),
                )),
          ],
        )));
  }
}
