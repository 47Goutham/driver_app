import 'package:get/get.dart';

class MyController extends GetxController{

  RxString phoneNumber = ''.obs;
  Rx<String?> phoneNumberError  = Rx<String?>(null) ;
  RxBool loading = false.obs;
  RxBool otpLoading = false.obs;
  RxBool otpError = false.obs;
  Rx<String?> userNameError  = Rx<String?>(null) ;
  RxBool userNameLoading = false.obs;

  void resetData(){
    phoneNumber = ''.obs;
    phoneNumberError  = Rx<String?>(null) ;
    loading = false.obs;
    otpLoading = false.obs;
    otpError = false.obs;
    userNameError  = Rx<String?>(null) ;
    userNameLoading = false.obs;
  }

}