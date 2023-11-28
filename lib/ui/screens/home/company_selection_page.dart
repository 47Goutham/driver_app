import 'package:flutter/material.dart';

class CompanySelectionPage extends StatelessWidget {
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose Company'),
          backgroundColor: Colors.yellow,
          titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 20, fontFamily: 'Roboto'),
          actions: [Image.asset('assets/images/logo.png')],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(Size(300, 80))),
                child: Text(
                  'RR',
                  style: TextStyle(color: Colors.black54,fontSize: 25 ,fontWeight: FontWeight.w400),
                )),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), minimumSize: MaterialStateProperty.all(Size(300, 80))),
                child: Text('JACOB KITCHEN', style: TextStyle(color: Colors.black54,fontSize: 25,fontWeight: FontWeight.w400))),
          ],
        )));
  }
}
