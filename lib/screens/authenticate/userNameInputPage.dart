import 'package:driver_app/screens/authenticate/error.dart';
import 'package:driver_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/services/pageController.dart';

import 'package:driver_app/screens/home/home.dart';


class UserNameInputPage extends StatelessWidget {
  UserNameInputPage({super.key});

  final TextEditingController userNameController = TextEditingController(text : FirebaseAuthController.auth.currentUser?.displayName);
  final MyController myController = Get.find<MyController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Enter Your Name'),
            backgroundColor: Colors.yellow,
            titleTextStyle: const TextStyle(
                color: Colors.black45, fontSize: 20, fontFamily: 'Roboto')
        ),
        body: Obx(() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      labelText: 'Enter Your Name' ,
                      errorText: myController.userNameError.value,
                      border: const OutlineInputBorder(),
                  ),

                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (userNameController.text.trim() == '') {
                    myController.userNameError.value = '';
                  } else {
                      String result;
                        if(FirebaseAuthController.auth.currentUser?.displayName != userNameController.text.trim() )
                      { myController.userNameLoading.value = true;
                        result = await Get.find<FirebaseAuthController>().updateName(userNameController.text.trim()); }
                        else {
                          result = 'success';
                        }

                      myController.resetData();
                      Get.off(
                              () => result =='success' ? const Home() : ErrorMassage(error: result) ,
                          transition: Transition.circularReveal
                      );

                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.yellow)),
                child: SizedBox(
                    width: 200,
                    height: 40,

                    child: Center(child: myController.userNameLoading.value
                        ?  LinearProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.black26,
                    )
                        : const Text('Submit',style: TextStyle(color: Colors.black45)))),
              ),
            ],
          ),
        ))
    );
  }

}







