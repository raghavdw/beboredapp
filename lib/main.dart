import 'package:flutter/material.dart';
import 'package:beboredapp/widgets/oscillating_bored.dart';
import 'plan_selection_screen.dart';
import 'settings_screen.dart';
import 'training_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalMinutes = 5;
  int totalSessions = 1;
  int sessionsCompleted = 0;
  double progress = 0.0;

  // Method to update the training plan with confirmation
  void _showTrainingPlanResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Training Plan'),
          content: Text(
              'Changing the training plan will reset your progress. Do you want to proceed?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanSelectionScreen(
                      onTrainingPlanSelected: (int minutes, int sessions) {
                        setState(() {
                          totalMinutes = minutes;
                          totalSessions = sessions;
                          sessionsCompleted = 0; // Reset progress
                          progress = 0.0;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BeBored'),
        backgroundColor: Colors.blueAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Training Plan'),
              onTap: _showTrainingPlanResetDialog, // Call reset confirmation
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OscillatingBored(), // The oscillating 'Bored' text widget
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainingScreen(
                      totalMinutes: totalMinutes,
                      totalSessions: totalSessions,
                      sessionsCompleted: sessionsCompleted,
                      onSessionCompleted: () {
                        setState(() {
                          sessionsCompleted++;
                          progress =
                              (sessionsCompleted / totalSessions) * 100;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    'Continue\nTraining',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Session: $totalMinutes min | $totalSessions sessions/day',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Progress: ${progress.toStringAsFixed(1)}% completed',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
