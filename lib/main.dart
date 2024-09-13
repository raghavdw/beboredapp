import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/oscillating_bored.dart';
import 'training_screen.dart';
import 'settings_screen.dart';
import 'plan_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeBored',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _sessionDuration = 5; // default value

  @override
  void initState() {
    super.initState();
    _loadSessionDuration();
  }

  Future<void> _loadSessionDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sessionDuration = prefs.getInt('sessionDuration') ?? 5; // Load saved duration
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BeBored'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OscillatingBored(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainingScreen(totalMinutes: _sessionDuration)),
                );
              },
              child: Text('Continue Training'),
            ),
            Text(
              'Session: $_sessionDuration min',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
