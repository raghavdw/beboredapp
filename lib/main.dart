import 'package:flutter/material.dart';
import 'widgets/start_screen.dart';
import 'widgets/main_screen.dart';
import 'widgets/training_screen.dart';
import 'widgets/plan_selection_screen.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => MainScreen(week: 1),  // Start with week 1
        '/training': (context) => TrainingScreen(sessionMinutes: 5),
        '/plan_selection': (context) => PlanSelectionScreen(
              onTrainingPlanSelected: (minutes, sessions) {
                // Handle plan selection
              },
            ),
      },
    );
  }
}
