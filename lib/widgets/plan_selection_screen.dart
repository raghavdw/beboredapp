import 'package:flutter/material.dart';
import 'week_state.dart';
import 'session_state.dart';

class PlanSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Training Plan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int week = 1; week <= 4; week++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: WeekState.isWeekUnlocked(week)
                      ? () {
                          Navigator.pushNamed(
                            context,
                            '/training',
                            arguments: {'week': week},
                          );
                        }
                      : null, // Button is disabled if the week is locked
                  child: Text('Week $week Plan'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
