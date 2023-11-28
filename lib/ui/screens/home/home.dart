import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
     body: Center(child: Text('HI'),),
    );
  }
}
