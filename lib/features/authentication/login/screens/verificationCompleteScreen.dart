import 'package:flutter/material.dart';

import '../../../../navigation_menu.dart';

class VerificationCompleteScreen extends StatefulWidget {
  @override
  _VerificationCompleteScreenState createState() =>
      _VerificationCompleteScreenState();
}

class _VerificationCompleteScreenState
    extends State<VerificationCompleteScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const  NavigationMenu()), // Replace with your home screen widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Widget
            Image.asset(
              'assets/images/content/Frame 106.png', // Add your image to assets folder and update the path
              width: double.infinity,
              height: 400,
            ),
           
          ],
        ),
      ),
    );
  }
}


