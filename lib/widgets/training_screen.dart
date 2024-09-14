import 'dart:async';
import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  final int sessionMinutes;
  TrainingScreen({required this.sessionMinutes});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late int totalSeconds;
  bool sessionStarted = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.sessionMinutes * 60; // Convert minutes to seconds
  }

  void _startSession() {
    setState(() {
      sessionStarted = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        setState(() {
          totalSeconds--;
        });
      } else {
        _stopSession();
      }
    });
  }

  void _stopSession() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      sessionStarted = false;
      totalSeconds = widget.sessionMinutes * 60; // Reset to initial time
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

    return WillPopScope(
      onWillPop: () async {
        return await _showConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Training Session'),
          actions: [
            if (sessionStarted)
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () => _showConfirmationDialog(context),
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stay Away From Your Phone!', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text(
                '$minutes:$seconds',
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 20),
              sessionStarted
                  ? ElevatedButton(
                      onPressed: () => _showConfirmationDialog(context),
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

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Stop Session'),
            content: Text('Do you want to stop the session?'),
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
        )) ??
        false;
  }
}
