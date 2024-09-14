import 'package:flutter/material.dart';

class WeekProgressTracker extends StatelessWidget {
  final int week;

  WeekProgressTracker({required this.week});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Week $week Progress'),
        // Add logic to display the week's progress here
      ],
    );
  }
}
