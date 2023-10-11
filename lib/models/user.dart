import 'package:driver_app/models/vehicle.dart';

class User {

  String? uid;
  String yandexId;
  Vehicle? currentVehicle;
  String name;
  String phone;
  String workRuleId;

  User({required this.name, required this.yandexId,required this.phone,required this.workRuleId});

  assignVehicle (Vehicle vehicle){
    currentVehicle = vehicle;
  }

}


