import 'package:flutter/material.dart';
import 'dart:math';

class OscillatingBored extends StatefulWidget {
  @override
  _OscillatingBoredState createState() => _OscillatingBoredState();
}

class _OscillatingBoredState extends State<OscillatingBored> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Text(
        'BeBored',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, sin(_controller.value * 2 * pi) * 10),
          child: child,
        );
      },
    );
  }
}
