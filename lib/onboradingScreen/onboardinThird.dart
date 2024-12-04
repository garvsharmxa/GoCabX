import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../features/home/widgets/bottomButton.dart';
import '../features/signup/signup.dart';
import 'widget/onboardingTextFirst.dart';

class OnboardingThird extends StatelessWidget {
  const OnboardingThird({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = MediaQuery.of(context).size.width * 0.8;
    final double maxWidthConstraint = 400.0;

    return Scaffold(
      backgroundColor: const Color(0xFFE6F5F3),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidthConstraint < maxContentWidth ? maxWidthConstraint : maxContentWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height:50.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF25B29F),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/images/animations/New_Loading_Car_GIF.json',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const OnboardingText(
                text: "Track Your Ride",
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              const OnboardingText(
                text: "Real-time updates at your fingertips.",
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
           
              Center(
                child: Lottie.asset(
                  'assets/images/animations/Splash-1Animation-Buzzcab.json',
                  width: double.infinity,
                  height: 400.0,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GradientButtonBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const  EnterMobileScreen()),
          );
        },
        buttonText: "Get Started",
      ),
    );
  }
}
