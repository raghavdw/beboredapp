// lib/training_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';

class TrainingScreen extends StatefulWidget {
  final int totalMinutes;

  TrainingScreen({required this.totalMinutes});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> with SingleTickerProviderStateMixin {
  late int remainingMinutes;
  Timer? _timer;
  double progress = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    remainingMinutes = widget.totalMinutes;
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    startTimer();
  }

  void startTimer() {
    int totalSeconds = remainingMinutes * 60;
    int elapsedSeconds = 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (elapsedSeconds < totalSeconds) {
          elapsedSeconds++;
          remainingMinutes = (totalSeconds - elapsedSeconds) ~/ 60;
          progress = elapsedSeconds / totalSeconds;
        } else {
          _timer?.cancel();
          _controller.stop();
          playCompletionSound();
          showCompletionDialog();
        }
      });
    });
  }

  void playCompletionSound() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/success.mp3"),
    );
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Session Complete!'),
          content: Text('Well done! You stayed away for ${widget.totalMinutes} minutes.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigate back to home screen
              },
            ),
          ],
        );
      },
    );
  }

  // Add this method to allow users to end their session early
  void endSessionEarly() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End Session?'),
          content: Text('Are you sure you want to end the session? Progress will not be counted.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('End Session'),
              onPressed: () {
                _timer?.cancel();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Return to the home screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Training Session'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: endSessionEarly, // Provide option to end session early
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stay Away From Your Phone!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * pi * (i % 2 == 0 ? 1 : -1),
                        child: child,
                      );
                    },
                    child: CustomPaint(
                      painter: CirclePainter(color: Colors.primaries[i % Colors.primaries.length]),
                      size: Size(200, 200),
                    ),
                  ),
                Center(
                  child: Text(
                    '$remainingMinutes min',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            if (remainingMinutes == 0)
              Text(
                'Session Completed! Well done!',
                style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
