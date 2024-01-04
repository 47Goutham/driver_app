import 'package:driver_app/models/user.dart';
import 'package:driver_app/models/vehicle.dart';
import 'package:driver_app/services/yandex_api.dart';

import '../UI/widgets/user_data_inherited_widget.dart';

class HelperFunctions {

  static Future<void> checkPhoneNumberExists (String phone, UserData userData) async {
     try {
       final result = await YandexApi.fetchDriverProfiles();


       for (final profile in result['driver_profiles']) {
         if (profile['driver_profile']['phones'][0] == phone) {


           userData.nameInYandex = profile['driver_profile']['first_name'] + ' ' + profile['driver_profile']['last_name'] ;
           userData.yandexId =  profile['driver_profile']['id'];
           userData.phoneNumberYandex = profile['driver_profile']['phones'][0];
           userData.workRuleId = profile['driver_profile']['work_rule_id'] ;

           userData.currentVehicleInYandex = profile['car'] != null ? Vehicle(id: profile['car']['id'],
                   licenseNo: profile['car']['number'],
                   brand: profile['car']['brand'],
                   model: profile['car']['model']) : null ;
           return ;

         }
       }
       throw 'Phone number not registered';
     } on Exception catch (e) {
       return Future.error(e);
     }
   }


  static Future<List<Vehicle>> fetchVehicles () async {
    try {
      final result = await YandexApi.fetchVehicles();
      List<Vehicle> vehicles = [];

      for (final car in result['cars']) {


        Vehicle vehicle =  Vehicle(id: car['id'], licenseNo: car['normalized_number'], brand:  car['brand'], model: car['model']) ;

          if(vehicle.type != 'OnFoot' ){
            vehicles.add(vehicle);
          }

      }

      if (vehicles.isEmpty) {
        throw 'No Vehicles Found';
      }else{
        return vehicles;
      }

    } on Exception catch (e) {
      return Future.error(e);
    }
  }



 static bool isValidArmenianPhoneNumber(String phoneNumber) {
    // Regular expression for Armenian phone numbers
    RegExp armenianPhoneNumberRegExp = RegExp(r'^\+374\d{8}$');

    return armenianPhoneNumberRegExp.hasMatch(phoneNumber);
  }

}
