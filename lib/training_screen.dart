import 'package:flutter/material.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:math';

class TrainingScreen extends StatefulWidget {
  final int totalMinutes;

  TrainingScreen({required this.totalMinutes});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.totalMinutes * 60; // Convert to seconds
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.totalMinutes * 60))
      ..repeat();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        _sessionComplete();
      }
    });
  }

  void _sessionComplete() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/success.mp3"),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session Complete!'),
        content: Text('You completed your session!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to home
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi * (i % 2 == 0 ? 1 : -1),
                    child: CustomPaint(
                      painter: CirclePainter(Colors.primaries[i]),
                      size: Size(200, 200),
                    ),
                  );
                },
              ),
            Text(
              '${(_remainingTime / 60).ceil()} min',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
