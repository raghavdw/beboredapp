import 'package:flutter/material.dart';
import 'widgets/start_screen.dart';
import 'widgets/main_screen.dart';
import 'widgets/training_screen.dart';
import 'widgets/plan_selection_screen.dart';
import 'widgets/settings_screen.dart';

void main() {
  runApp(BeBoredApp());
}

class BeBoredApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeBored',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => MainScreen(week: 1), // Updated to use /home route
        '/training': (context) => TrainingScreen(sessionMinutes: 5), // Pass session minutes
        '/plan_selection': (context) => PlanSelectionScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
