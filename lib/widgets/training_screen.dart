import 'package:flutter/material.dart';
import 'dart:async';  // Required for countdown timer

class TrainingScreen extends StatefulWidget {
  final int sessionMinutes;

  TrainingScreen({required this.sessionMinutes});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late int minutesLeft;  // Proper initialization
  late int secondsLeft;  // To track seconds within a minute
  bool sessionStarted = false;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    minutesLeft = widget.sessionMinutes;
    secondsLeft = 0;  // Start with 0 seconds
  }

  void _startSession() {
    setState(() {
      sessionStarted = true;
    });
    _startCountdown();
  }

  void _startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else if (minutesLeft > 0) {
          minutesLeft--;
          secondsLeft = 59;
        } else {
          _stopCountdown();
          _showSessionCompletedDialog();
        }
      });
    });
  }

  void _stopCountdown() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
  }

  void _showSessionCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session Completed'),
        content: Text('Congratulations! You have completed your session.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _stopSession();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _stopSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stop Session'),
        content: Text('Are you sure you want to stop the session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                sessionStarted = false;
                minutesLeft = widget.sessionMinutes;
                secondsLeft = 0;  // Reset the session time
                _stopCountdown();
              });
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopCountdown();  // Ensure timer is canceled when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Session'),
        actions: [
          if (sessionStarted)
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: _stopSession,
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stay Away From Your Phone!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '${minutesLeft.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            sessionStarted
                ? ElevatedButton(
                    onPressed: _stopSession,
                    child: Text('Stop Session'),
                  )
                : ElevatedButton(
                    onPressed: _startSession,
                    child: Text('Start Session'),
                  ),
          ],
        ),
      ),
    );
  }
}
