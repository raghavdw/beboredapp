import 'package:flutter/material.dart';
import 'week_progress_tracker.dart';
import 'session_state.dart';
import 'plan_selection_screen.dart';

class MainScreen extends StatefulWidget {
  final int week;

  MainScreen({required this.week});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentDaySessions = 0;
  int totalDaySessions = 3; // Default for demonstration, you can update based on the week

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Plan - Week ${widget.week}'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Daily Session Progress Tracker
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Daily Progress', style: TextStyle(fontSize: 20)),
                LinearProgressIndicator(
                  value: currentDaySessions / totalDaySessions,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                SizedBox(height: 10),
                Text('$currentDaySessions / $totalDaySessions sessions completed'),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Button to Start Training
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/training');
            },
            child: Text('Start Training'),
          ),
          SizedBox(height: 20),
          // Weekly Progress Tracker
          WeekProgressTracker(currentWeek: widget.week),
        ],
      ),
    );
  }
}
