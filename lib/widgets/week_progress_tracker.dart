import 'package:flutter/material.dart';

class WeekProgressTracker extends StatelessWidget {
  final int week;

  const WeekProgressTracker({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample progress data for each day of the week.
    // This could be passed dynamically based on the user's training.
    List<Map<String, dynamic>> dailyProgress = [
      {"day": "Mon", "completed": true},
      {"day": "Tue", "completed": true},
      {"day": "Wed", "completed": false},
      {"day": "Thu", "completed": false},
      {"day": "Fri", "completed": false},
      {"day": "Sat", "completed": false},
      {"day": "Sun", "completed": false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Week $week Progress Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: dailyProgress.map((day) {
            return Column(
              children: [
                Text(
                  day["day"],
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Icon(
                  day["completed"] ? Icons.check_circle : Icons.cancel,
                  color: day["completed"] ? Colors.green : Colors.red,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
