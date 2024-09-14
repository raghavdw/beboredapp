import 'package:flutter/material.dart';
import 'logo_widget.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(width: 150, height: 150),
            SizedBox(height: 20),
            Text(
              'BeBored',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Continue Training'),
            ),
          ],
        ),
      ),
    );
  }
}
