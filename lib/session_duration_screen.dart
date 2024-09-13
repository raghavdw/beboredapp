import 'package:flutter/material.dart';

class SessionDurationScreen extends StatelessWidget {
  final int week;

  SessionDurationScreen({required this.week});

  @override
  Widget build(BuildContext context) {
    final List<int> durations = _getDurationsForWeek(week);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Duration for Week $week'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: durations.map((duration) {
          return ListTile(
            title: Text('$duration minutes'),
            onTap: () {
              Navigator.pop(context, duration);  // Return the selected duration
            },
          );
        }).toList(),
      ),
    );
  }

  List<int> _getDurationsForWeek(int week) {
    switch (week) {
      case 1:
        return [1, 2, 5, 10];
      case 2:
        return [5, 10, 15];
      case 3:
        return [10, 15, 20];
      case 4:
        return [15, 20, 25, 30];
      case 5:
        return [20, 30, 40];
      case 6:
        return [30, 45];
      case 7:
        return [45, 50, 60];
      case 8:
        return [60, 75];
      default:
        return [5];
    }
  }
}
