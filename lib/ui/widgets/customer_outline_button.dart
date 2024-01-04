import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Widget? nextWidget;
  final String label;
  final String subLabel;
  const CustomOutlineButton({super.key, required this.nextWidget, required this.label, required this.subLabel});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onLongPress: () {
        nextWidget != null ?
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              const begin = 0.0;
              const end = 1.0;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);
              return ScaleTransition(scale: offsetAnimation, child: nextWidget);
            },
            transitionDuration: Duration(milliseconds: 500), // Increase the duration to slow down the animation
          ),
        ) : null;
      },
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Colors.white,width: 0)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
        overlayColor: MaterialStateProperty.all<Color>(Colors.yellow.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '   $subLabel',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
        ],
      ),
    );
  }
}
