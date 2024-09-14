import 'package:flutter/material.dart';
import 'oscillating_bored.dart'; // Import the OscillatingBoredWidget

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Oscillating "BeBored" logo
          OscillatingBoredWidget(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
