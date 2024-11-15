import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/onboardingTextFirst.dart';

class Onboardingsecond extends StatelessWidget {
  const Onboardingsecond({super.key});

  @override
  Widget build(BuildContext context) {
        final double maxContentWidth = MediaQuery.of(context).size.width * 0.8;
    final double maxWidthConstraint = 400.0;
    return Scaffold(
      backgroundColor: Color(0xFFE6F5F3),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidthConstraint < maxContentWidth ? maxWidthConstraint : maxContentWidth,
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
              Center(
  child: Image.asset('assets/images/Property1=Default.png'),
  
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
    child: const Text("Get Started",
    style: TextStyle(
      color: Colors.white
    ),),
  ),
)

      ),
    );
  }
}