import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'week_progress_tracker.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  final int week;
  final int totalSessions;
  final int completedSessions;

  const MainScreen({
    Key? key,
    required this.week,
    required this.totalSessions,
    required this.completedSessions,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double progress = widget.completedSessions / widget.totalSessions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
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
            SizedBox(height: 20),
            Text(
              'Week ${widget.week} Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearPercentIndicator(
              lineHeight: 8.0,
              percent: progress,
              backgroundColor: Colors.grey[300],
              progressColor: Colors.blue,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/training');
              },
              child: Text('Continue Training'),
            ),
            SizedBox(height: 30),
            WeekProgressTracker(week: widget.week), // Weekly progress tracker
          ],
        ),
      ),
    );
  }
}
