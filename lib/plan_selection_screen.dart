import 'package:flutter/material.dart';

class PlanSelectionScreen extends StatelessWidget {
  final Function(int, int) onTrainingPlanSelected;

  PlanSelectionScreen({required this.onTrainingPlanSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Training Plan'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('5 min / 1 session per day'),
            onTap: () {
              onTrainingPlanSelected(5, 1);
              Navigator.pop(context); // Return to the previous screen
            },
          ),
          ListTile(
            title: Text('10 min / 2 sessions per day'),
            onTap: () {
              onTrainingPlanSelected(10, 2);
              Navigator.pop(context); // Return to the previous screen
            },
          ),
          // Add more training plans here
        ],
      ),
    );
  }
}
