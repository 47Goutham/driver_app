import 'dart:ffi';

import 'package:driver_app/services/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';

import 'package:driver_app/models/vehicle.dart';

class VehicleSelectionPage extends StatefulWidget {
  const VehicleSelectionPage({super.key});

  @override
  State<VehicleSelectionPage> createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> {
  bool dropdownMenuEnabled = false;
  String? dropdownMenuErrorText;
  bool loading = true;
  List<Vehicle> vehicleList = [];

  @override
  void initState() {
    super.initState();
    HelperFunctions.fetchVehicles().then((vehicles) {
      vehicleList = vehicles;

      setState(() {
        loading = false;
        dropdownMenuEnabled = true;
        dropdownMenuErrorText = null;
      });
    }).catchError((e) {
      setState(() {
        dropdownMenuErrorText = e;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Your Vehicle'),
          backgroundColor: Colors.yellow,
          titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
          actions: [Image.asset('assets/images/logo.png')],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu<Vehicle>(

              enableFilter: true,
              enabled: dropdownMenuEnabled,
              errorText: dropdownMenuErrorText,
              enableSearch: true,
              requestFocusOnTap: true,
              menuHeight: 200,
              width: 300,
              label: Text('Select Vehicle'),
              inputDecorationTheme: InputDecorationTheme(
                // fillColor: Colors.yellow[50],
                // filled: true,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black45, // Set your desired border color
                  ),
                ),
              ),
              dropdownMenuEntries: vehicleList
                  .map((vehicle) => DropdownMenuEntry(
                        value: vehicle, label: '${vehicle.licenseNo} ${vehicle.type == 'Car' ? '${vehicle.brand} ${vehicle.model}' : ''}',
                        leadingIcon: vehicle.type == 'Car' ? Icon(Icons.local_taxi) : Icon(Icons.moped),

                        // style: ButtonStyle(
                        //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //     RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       side: BorderSide(color: Colors.black45),
                        //     ),
                        //   ),
                        // ),
                      ))
                  .toList(),

              // menuStyle: MenuStyle(
              //
              //   elevation: MaterialStateProperty.all(0),
              //   backgroundColor: MaterialStateProperty.all(Colors.white)
              //   ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: Center(
                child: loading
                    ? const LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.black26,
                      )
                    : null,
              ),
            ),

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
