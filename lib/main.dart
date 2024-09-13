import 'package:flutter/material.dart';
import 'package:beboredapp/start_screen.dart';
import 'package:beboredapp/training_screen.dart';
import 'package:beboredapp/plan_selection_screen.dart';
import 'package:beboredapp/session_duration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeBored App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => HomeScreen(),
        '/training': (context) => TrainingScreen(totalMinutes: 5), // Default 5 min for now
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMinutes = 5;
  int sessionsPerDay = 1;
  double progress = 0.0;

  void _startTrainingSession() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingScreen(totalMinutes: selectedMinutes),
      ),
    );
  }

  void _selectTrainingPlan(int minutes, int sessions) {
    setState(() {
      selectedMinutes = minutes;
      sessionsPerDay = sessions;
      progress = 0.0; // Reset progress when changing plan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BeBored'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('BeBored Menu'),
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Training Plan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanSelectionScreen(
                      onTrainingPlanSelected: _selectTrainingPlan,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue Training',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Session: $selectedMinutes min | $sessionsPerDay sessions/day',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Progress: ${progress * 100} % completed',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _startTrainingSession,
              child: Text('Continue Training'),
            ),
          ],
        ),
      ),
    );
  }
}
