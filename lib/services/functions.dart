import 'package:driver_app/models/user.dart';
import 'package:driver_app/models/vehicle.dart';
import 'package:driver_app/services/yandex_api.dart';

class Functions {
  final api = YandexApi();
   Future<dynamic> checkPhoneNumberExists (String phone) async {

     final result = await api.fetchDriverProfiles();

     if(result == null) {
       return 'error';
     }
    for (final profile in result['driver_profiles']){
         if(profile['driver_profile']['phones'][0] == phone){

        return    YandexUser(name: profile['driver_profile']['first_name'] + ' ' + profile['driver_profile']['last_name'] ,
                         yandexId: profile['driver_profile']['id'] ,
                         phone: profile['driver_profile']['phones'][0],
                         workRuleId:profile['driver_profile']['work_rule_id'],
                         currentVehicle:  profile['driver_profile']['car'] != null ? Vehicle(id: profile['driver_profile']['car']['id'], licenseNo: profile['driver_profile']['car']['number'], brand: profile['driver_profile']['car']['brand'], model: profile['driver_profile']['car']['model']) : null );

         }
    }
    return 'Phone number not registered';
  }

}
