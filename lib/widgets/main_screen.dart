import 'package:flutter/material.dart';
import 'week_progress_tracker.dart'; // Updated to show progress

class MainScreen extends StatelessWidget {
  final int week;

  MainScreen({required this.week});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Training Progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            WeekProgressTracker(week: week), // Pass the week parameter
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/training');
              },
              child: Text('Continue Training'),
            ),
          ],
        ),
      ),
    );
  }
}
