import 'package:buzzcab/features/authentication/signup/rider_signup/riderSignup.dart';
import 'package:flutter/material.dart';
import '../../features/home/widgets/bottomButton.dart';
import '../widget/onboardingTextFirst.dart';

class RiderOnboardingSecond extends StatelessWidget {
  const RiderOnboardingSecond({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black // Dark theme background color
          : const Color(0xFFE6F5F3), // Light theme background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF25B29F),
                  child: Image.asset(
                    'assets/logos/applogo.png',
                    height: 40,
                    width: 40,
                  )),
              const SizedBox(height: 24),
              Text(
                'Boost Your Earnings!',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              const OnboardingText(
                text: "Drive with BuzzCabs and Make Every \nMile Count",
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/animations/boost_your_earnings.png",
                    // scale: .5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: GradientButtonBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiderSignupScreen()),
            );
          },
          buttonText: "Get Started",
        ),
      ),
    );
  }
}
