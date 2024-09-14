import 'package:flutter/material.dart';

class WeekProgressTracker extends StatelessWidget {
  final int currentWeek;

  WeekProgressTracker({required this.currentWeek});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int week = 1; week <= 4; week++)
          ListTile(
            title: Text('Week $week'),
            trailing: Icon(
              week <= currentWeek ? Icons.lock_open : Icons.lock,
              color: week <= currentWeek ? Colors.green : Colors.grey,
            ),
          ),
      ],
    );
  }
}
