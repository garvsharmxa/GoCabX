import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../featuresDriver/home/widgets/bottomButton.dart';
import '../../featuresDriver/onboradingScreen/user_rider_switch.dart';
import '../../featuresDriver/onboradingScreen/widget/onboardingTextFirst.dart';


class OnboardingFirst extends StatelessWidget {
  const OnboardingFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : const Color(0xFFE6F5F3);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150.0,
            decoration: const BoxDecoration(
              color: Color(0xFF25B29F),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/logos/applogo.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const OnboardingText(
            text: "Welcome To",
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          const OnboardingText(
            text: "BuzzCabs!",
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 32),
          Center(
            child: Lottie.asset(
              'assets/images/animations/Intro_Screen_animation-BuzzCab.json',
              width: double.infinity,
              height: 200.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 8),
        child: GradientButtonBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChoosePathScreen()),
            );
          },
          buttonText: "Get Started",
        ),
      ),
    );
  }
}