import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About BeBored'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Website'),
            Text('Terms of Service'),
            Text('Privacy Policy'),
            SizedBox(height: 20),
            Text(
              'Need Help?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Contact Us'),
            SizedBox(height: 20),
            Text(
              'Give Us a Follow',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('BeBored on Social Media'),
            Spacer(),
            Text(
              'Use of this app constitutes acceptance of our Terms & Conditions. All rights reserved.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
