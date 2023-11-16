import 'package:flutter/material.dart';



class UserNameInputPage extends StatefulWidget {
  const UserNameInputPage({super.key});

  @override
  UserNameInputPageState createState() => UserNameInputPageState();
}
class UserNameInputPageState extends State<UserNameInputPage> {
  final TextEditingController userNameController = TextEditingController();
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter User Name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'Enter User Name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = userNameController.text;
                  // Here you can implement logic to store the user's name or proceed further
                  // For demo purposes, let's print the username
                  print('Entered username: $userName');
                  // You can navigate to the next screen or perform necessary actions here
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}





