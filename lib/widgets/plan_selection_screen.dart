import 'package:flutter/material.dart';

class PlanSelectionScreen extends StatelessWidget {
  final Function(int, int) onTrainingPlanSelected;

  PlanSelectionScreen({required this.onTrainingPlanSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Training Plan'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Week 1: 5 min / 2 sessions per day'),
            onTap: () {
              onTrainingPlanSelected(5, 2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Week 2: 10 min / 3 sessions per day'),
            onTap: () {
              onTrainingPlanSelected(10, 3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Week 3: 15 min / 3 sessions per day'),
            onTap: () {
              onTrainingPlanSelected(15, 3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Week 4: 20 min / 4 sessions per day'),
            onTap: () {
              onTrainingPlanSelected(20, 4);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
