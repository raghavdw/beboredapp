import 'package:flutter/material.dart';

class OscillatingBoredWidget extends StatefulWidget {
  final double amplitude; // Controls how much the text moves

  const OscillatingBoredWidget({Key? key, this.amplitude = 10.0}) : super(key: key);

  @override
  _OscillatingBoredWidgetState createState() => _OscillatingBoredWidgetState();
}

class _OscillatingBoredWidgetState extends State<OscillatingBoredWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Setup animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Setup animation to move the "Bored" text
    _animation = Tween<double>(begin: -widget.amplitude, end: widget.amplitude).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // "Be" Text stays static
        Text(
          'Be',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 5), // Spacing between "Be" and "Bored"

        // Animated "Bored" text
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value), // Move vertically based on animation value
              child: Text(
                'Bored',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // You can match this to your logo colors
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
