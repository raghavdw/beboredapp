import 'package:flutter/material.dart';
import 'dart:async';

class TrainingScreen extends StatefulWidget {
  final int sessionMinutes;

  TrainingScreen({required this.sessionMinutes});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late int minutesLeft;
  late Timer _timer;
  bool sessionStarted = false;

  @override
  void initState() {
    super.initState();
    minutesLeft = widget.sessionMinutes;
  }

  void _startSession() {
    setState(() {
      sessionStarted = true;
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutesLeft > 0) {
        setState(() {
          minutesLeft--;
        });
      } else {
        _stopSession();
      }
    });
  }

  void _stopSession() {
    _timer.cancel();
    setState(() {
      sessionStarted = false;
      minutesLeft = widget.sessionMinutes; // Reset to initial time
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _confirmStopSession();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Training Session'),
          actions: [
            if (sessionStarted)
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: _confirmStopSession,
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stay Away From Your Phone!'),
              SizedBox(height: 20),
              Text(
                '${minutesLeft.toString().padLeft(2, '0')}:00',
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 20),
              sessionStarted
                  ? ElevatedButton(
                      onPressed: _confirmStopSession,
                      child: Text('Stop Session'),
                    )
                  : ElevatedButton(
                      onPressed: _startSession,
                      child: Text('Start Session'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmStopSession() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stop Session'),
        content: Text('Are you sure you want to stop this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              _stopSession();
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
