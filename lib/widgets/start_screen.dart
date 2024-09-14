import 'package:flutter/material.dart';
import 'logo_widget.dart'; // Import the LogoWidget

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo with oscillating "Bored"
            LogoWidget(width: 150, height: 150),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Navigate to MainScreen
              },
              child: Text('Continue Training'),
            ),
          ],
        ),
      ),
    );
  }
}
