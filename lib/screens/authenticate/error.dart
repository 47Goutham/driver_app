import 'package:flutter/material.dart';

class ErrorMassage extends StatelessWidget {
  final String? error;
  const ErrorMassage({super.key,required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(error!))
    );

  }
}
