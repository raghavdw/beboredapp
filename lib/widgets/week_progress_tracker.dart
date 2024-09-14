import 'package:flutter/material.dart';

class WeekProgressTracker extends StatelessWidget {
  final int week;

  WeekProgressTracker({required this.week});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Week $week Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Add your tracker logic or UI here
        LinearProgressIndicator(
          value: 0.5, // This would be dynamically updated based on session progress
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }
}
