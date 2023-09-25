import 'package:driver_app/services/yandex_api.dart';

class Functions {
  final api = YandexApi();
   Future<String> checkPhoneNumberExists (String phone) async {

     final result = await api.fetchDriverProfiles();

     if(result == null) {
       return 'error';
     }
     print(result);
    for (final profile in result['driver_profiles']){
       print(profile['driver_profile']['phones'][0]);
       print(phone);
         if(profile['driver_profile']['phones'][0] == phone){
           return profile['driver_profile']['id'];
         }
    }
    print('here');
    return 'Phone number not registered';
  }

}