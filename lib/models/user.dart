import 'package:driver_app/models/vehicle.dart';


class MyUser {
  final String uid;
  MyUser({required this.uid});

}

class UserData {

  String? uid;
  String yandexId;
  Vehicle? currentVehicle;
  String name;
  String phone;
  String workRuleId;

  UserData({required this.name, required this.yandexId,required this.phone,required this.workRuleId,required this.currentVehicle});



}


