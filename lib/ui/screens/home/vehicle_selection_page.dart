import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';

class VehicleSelectionPage extends StatefulWidget {
  const VehicleSelectionPage({super.key});

  @override
  State<VehicleSelectionPage> createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Your Vehicle'),
          backgroundColor: Colors.yellow,
          titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
          actions: [Image.asset('assets/images/logo.png')],
        ),
        body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu<String>(
                  enableFilter: true,
                  enableSearch: true,
                  requestFocusOnTap: true,
                  dropdownMenuEntries: [
                     DropdownMenuEntry(value: 'Goutham', label: 'Goutham'),
                    DropdownMenuEntry(value: 'Nana', label: 'nana'),
                    DropdownMenuEntry(value: 'Julia', label: 'Julia'),
                    DropdownMenuEntry(value: 'Park', label: 'Park'),
                    DropdownMenuEntry(value: 'Disha', label: 'Disha'),
                  ],
                )
                // ElevatedButton(
                //     onPressed: loading
                //         ? null
                //         : ()  {
                //       final phoneNumber = phoneNumberController.text.trim();
                //
                //       if (phoneNumber.isEmpty || phoneNumber == '+374') {
                //         setState(() {
                //           phoneNumberError = 'Please enter phone number';
                //         });
                //       } else if (!HelperFunctions.isValidArmenianPhoneNumber(phoneNumber)) {
                //         setState(() {
                //           phoneNumberError = 'Invalid Armenian Number';
                //         });
                //       } else if (phoneNumber == FirebaseAuthService.currentFirebaseUser()!.phoneNumber && selected[1] == true) {
                //         setState(() {
                //           phoneNumberError = 'This is your Own Account number';
                //         });
                //       } else {
                //         setState(() {
                //           phoneNumberError = null;
                //           loading = true;
                //         });
                //
                //
                //
                //         HelperFunctions.checkPhoneNumberExists(phoneNumber, UserDataInheritedWidget.of(context).userData).then((val) {
                //           Navigator.of(context).pushReplacement(
                //             PageRouteBuilder<void>(
                //               pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                //                 const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                //                 const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                //                 var tween = Tween(begin: begin, end: end);
                //
                //                 var offsetAnimation = animation.drive(tween);
                //                 return SlideTransition(position: offsetAnimation, child: const Home());
                //               },
                //               transitionDuration: const Duration(milliseconds: 500), // Increase the duration to slow down the animation
                //             ),
                //           );
                //         }).catchError((err) {
                //           setState(() {
                //             phoneNumberError = err;
                //             loading = false;
                //           });
                //         });
                //       }
                //     },
                //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                //     child: SizedBox(
                //       height: 40,
                //       width: 200,
                //       child: Center(
                //         child: loading
                //             ? const LinearProgressIndicator(
                //           color: Colors.black,
                //           backgroundColor: Colors.black26,
                //         )
                //             : const Text('Next', style: TextStyle(color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w400)),
                //       ),
                //     )),
              ],
            )));
  }
}
