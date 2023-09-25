import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: SpinKitSpinningCircle(
              color: Colors.yellow,
              size:50
          )
      ),
    );
  }
}
