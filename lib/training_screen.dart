import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TrainingScreen extends StatefulWidget {
  final int totalMinutes;
  final int totalSessions;
  final int sessionsCompleted;
  final Function onSessionCompleted;

  TrainingScreen({
    required this.totalMinutes,
    required this.totalSessions,
    required this.sessionsCompleted,
    required this.onSessionCompleted,
  });

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    with SingleTickerProviderStateMixin {
  late int remainingMinutes;
  Timer? _timer;
  late AnimationController _controller;
  bool sessionInProgress = true; // Track if the session is active

  @override
  void initState() {
    super.initState();
    remainingMinutes = widget.totalMinutes;
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Automatically start the timer
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
        } else {
          _timer?.cancel();
          sessionInProgress = false;
          widget.onSessionCompleted(); // Complete session and update progress
          Navigator.pop(context); // Go back to home screen when session is done
        }
      });
    });
  }

  void stopSession() {
    // Cancel the timer if session is stopped
    _timer?.cancel();
    sessionInProgress = false;
  }

  void _showStopConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stop Session'),
          content: Text('Are you sure you want to stop the session? Progress will not be saved.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Stop'),
              onPressed: () {
                stopSession();
                Navigator.of(context).pop(); // Dismiss the dialog
                Navigator.pop(context); // Go back to the home screen
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
    return GestureDetector(
      onTap: () {
        // Show stop confirmation dialog on user interaction
        _showStopConfirmation();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
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
                    painter: CirclePainter(color: Colors.primaries[i]),
                    size: Size(200, 200),
                  ),
                ),
              Center(
                child: Text(
                  '$remainingMinutes min',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
    return true; // Repaint continuously
  }
}
