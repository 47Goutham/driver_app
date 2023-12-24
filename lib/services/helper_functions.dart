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
           userData.currentVehicleInYandex = profile['driver_profile']['car'] != null ? Vehicle(id: profile['driver_profile']['car']['id'],
                   licenseNo: profile['driver_profile']['car']['number'],
                   brand: profile['driver_profile']['car']['brand'],
                   model: profile['driver_profile']['car']['model']) : null ;
           return ;

         }
       }
       throw 'Phone number not registered';
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
