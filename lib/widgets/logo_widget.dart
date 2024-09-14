import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({this.width = 150, this.height = 150});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/be_bored_logo.png', // Ensure the correct path to the logo
      width: width,
      height: height,
    );
  }
}
