import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/onboardingTextFirst.dart';

class Onboardingsecond extends StatefulWidget {
  const Onboardingsecond({super.key});

  @override
  _OnboardingsecondState createState() => _OnboardingsecondState();
}

class _OnboardingsecondState extends State<Onboardingsecond> {
  double imagePosition = -1.0; // Start off-screen to the left

  @override
  void initState() {
    super.initState();
    // Delay animation to ensure the first image is shown first
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        imagePosition = 1.0; // Move second image to the center
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = MediaQuery.of(context).size.width * 0.8;
    final double maxWidthConstraint = 400.0;

    return Scaffold(
      backgroundColor: Color(0xFFE6F5F3),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidthConstraint < maxContentWidth
                ? maxWidthConstraint
                : maxContentWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Color(0xFF25B29F),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/onboradinglogo1.png',
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const OnboardingText(
                text: "Welcome To",
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              const OnboardingText(
                text: "Buzz Cab !",
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 32),
              Stack(
                children: [
                  Image.asset('assets/images/Property1=Default.png'),
                  AnimatedPositioned(
                    duration: Duration(seconds: 1), // Set duration for animation
                    left: imagePosition * MediaQuery.of(context).size.width,
                    top: 0,
                    child: Image.asset('assets/images/Property1=Animated.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF211F96), Color(0xFF1F9686)], // Start and end colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0), // Optional: match button's shape
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Make button background transparent
              shadowColor: Colors.transparent, // Remove shadow if desired
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              textStyle: GoogleFonts.montserrat(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
