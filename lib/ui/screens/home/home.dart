import 'package:driver_app/UI/screens/home/company_selection_page.dart';
import 'package:driver_app/UI/screens/home/rr_account_selection_page.dart';
import 'package:driver_app/services/database.dart';
import 'package:driver_app/ui/screens/home/vehicle_selection_page.dart';
import 'package:driver_app/ui/widgets/customer_outline_button.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
        actions: [Hero(tag: 'hero_logo', child: Image.asset('assets/images/logo.png'))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/logo.png'), // Add your driver's avatar image
              ),
              const SizedBox(height: 20),
              Text(
                UserDataInheritedWidget.of(context).userData.nameReal ?? '-',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomOutlineButton(nextWidget: const VehicleSelectionPage(), label: 'Current Vehicle', subLabel: UserDataInheritedWidget.of(context).userData.currentVehicleReal?.name ?? 'None'),
              const SizedBox(
                height: 8,
              ),
              CustomOutlineButton(nextWidget: const CompanySelectionPage(), label: 'Company', subLabel: UserDataInheritedWidget.of(context).userData.workingCompany ?? 'None'),
              const SizedBox(
                height: 8,
              ),
              CustomOutlineButton(nextWidget: const AccountSelectionPage(), label: 'Yandex Account', subLabel: UserDataInheritedWidget.of(context).userData.nameInYandex ?? 'None'),
              const SizedBox(
                height: 8,
              ),

              CustomOutlineButton(nextWidget: null, label: 'Yandex Account Vehicle', subLabel: UserDataInheritedWidget.of(context).userData.currentVehicleInYandex?.name??'None')
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 90,
        height: 90,
        child: FloatingActionButton(
          onPressed: () {

            setState(() {
              UserDataInheritedWidget.of(context).userData.startStop = UserDataInheritedWidget.of(context).userData.startStop == 'START' ? 'STOP' : 'START';
            });

            Map<String, dynamic> data = {
            'yandexId' : UserDataInheritedWidget.of(context).userData.yandexId,
            'currentVehicleReal' : UserDataInheritedWidget.of(context).userData.currentVehicleReal?.name,
            'workingCompany' : UserDataInheritedWidget.of(context).userData.workingCompany,
            'start_stop': UserDataInheritedWidget.of(context).userData.startStop

            };

            FirebaseDataBaseService.pushDataAtUid(UserDataInheritedWidget.of(context).userData.uid!, data);
          },
          backgroundColor: Colors.yellow,
          shape: CircleBorder(),
          child: Icon(
            Icons.play_arrow,
            size: 70,
          ),
        ),
      ),
    );
  }
}
