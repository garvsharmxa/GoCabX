import 'package:buzzcab/featuresDriver/onboradingScreen/user_onboarding/onboardinThird.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../features/authentication/login/screens/enterMobileNumber.dart';
import '../../home/widgets/bottomButton.dart';
import '../widget/onboardingTextFirst.dart';

class OnboardingSecond extends StatelessWidget {
  const OnboardingSecond({super.key});

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
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'RIDE WITH',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const TextSpan(
                      text: ' BUZZCABS!',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFF5722),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const OnboardingText(
                text: "Ride with Ease!",
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    'assets/images/animations/Splash-1Animation-Buzzcab.json',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GradientButtonBar(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnboardingThird()),
                  );
                },
                buttonText: "Next",
              ),
            ),
            const SizedBox(width: 16), // Add spacing between buttons
            Expanded(
              child: GradientButtonBar(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EnterMobileScreen()),
                  );
                },
                buttonText: "SKIP",
              ),
            ),
          ],
        ),
      ),
    );
  }
}