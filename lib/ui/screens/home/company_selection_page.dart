import 'package:driver_app/UI/screens/home/rr_account_selection_page.dart';
import 'package:driver_app/ui/screens/home/vehicle_selection_page.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';

import 'home.dart';

class CompanySelectionPage extends StatelessWidget {
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose Company'),
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
          children: [
            ElevatedButton(
                onPressed: () {
                  UserDataInheritedWidget.of(context).userData.workingCompany = 'RR';

                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                        const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                        const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                        var tween = Tween(begin: begin, end: end);

                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation,
                            child: const AccountSelectionPage()
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300), // Increase the duration to slow down the animation
                    ),
                  );

                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(const Size(300, 80))),
                child: const Text(
                  'RR',
                  style: TextStyle(color: Colors.black54,fontSize: 25 ,fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  UserDataInheritedWidget.of(context).userData.workingCompany = 'JACOB KITCHEN';

                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                        const Offset begin = Offset(1.0, 0.0); // starting position (right of the screen)
                        const Offset end = Offset(0.0, 0.0); // ending position (left of the screen)
                        var tween = Tween(begin: begin, end: end);

                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation,
                            child: UserDataInheritedWidget.of(context).userData.currentVehicleReal == null ? const VehicleSelectionPage() : Home()
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300), // Increase the duration to slow down the animation
                    ),
                  );

                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(const Size(300, 80))),
                child: const Text('JACOB KITCHEN', style: TextStyle(color: Colors.black54,fontSize: 25,fontWeight: FontWeight.w400))),
          ],
        )));
  }
}

