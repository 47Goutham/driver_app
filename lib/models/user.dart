import 'package:driver_app/models/vehicle.dart';

class YandexUser {

  String? firebaseUid;
  String yandexId;
  Vehicle? currentVehicle;
  String name;
  String phone;
  String workRuleId;

  YandexUser({required this.name, required this.yandexId,required this.phone,required this.workRuleId,required this.currentVehicle});



}


