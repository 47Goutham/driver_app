import 'package:flutter/material.dart';

import 'package:driver_app/ui/widgets/user_data_inherited_widget.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  void initState() {
    super.initState();



  }


  @override
  Widget build(BuildContext context) {

    UserDataInheritedWidget.of(context).userData.nameReal = 'Goutham tinglekar';
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
        actions: [
          Hero(tag: 'hero_logo',
              child: Image.asset('assets/images/logo.png'))
        ],
      ),
     body:

     Padding(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
      child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage('assets/images/logo.png'), // Add your driver's avatar image
        ),
        SizedBox(height: 20),
        Text(
        'Goutham Tinglekar',
        style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 10),
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
            'Current Vehicle: Opel Corsa',
            style: TextStyle(
            fontSize: 18,
            ),
            ),
            IconButton(
              icon: Icon(Icons.edit,size: 15),
              onPressed: () {
                // Add your edit functionality here
              },
            ),
          ],
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Company: RR',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit,size: 15),
                onPressed: () {
                  // Add your edit functionality here
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Yandex Account: Raj Malhothra',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit,size: 15),
                onPressed: () {
                  // Add your edit functionality here
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Yandex Account Vehicle: AD155',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit,size: 15),
                onPressed: () {
                  // Add your edit functionality here
                },
              ),
            ],
          ),

        ],),
      ),
    ),


      floatingActionButton:  SizedBox(
        width: 90,
        height: 90,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {

            });
          },
         // foregroundColor: customizations[index].$1,
          backgroundColor: Colors.yellow,
          shape: CircleBorder(),
          child: Icon(Icons.play_arrow,size: 70,),

        ),
      ),


    );
  }
}
