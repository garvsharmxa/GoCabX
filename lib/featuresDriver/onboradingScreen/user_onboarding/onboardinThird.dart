import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../features/authentication/login/screens/enterMobileNumber.dart';
import '../../home/widgets/bottomButton.dart';
class OnboardingThird extends StatelessWidget {
  const OnboardingThird({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : const Color(0xFFE6F5F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF25B29F),
                child: Image.asset(
                  'assets/logos/applogo.png',
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Track Your Ride",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Real-time updates at your fingertips.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    'assets/images/animations/Splash-2Animation-Buzzcab.json',
                    width: maxContentWidth,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
       padding: const EdgeInsets.only(left: 12,right: 12,bottom: 8),
        child: GradientButtonBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EnterMobileScreen()),
            );
          },
          buttonText: "Get Started",
        ),
      ),
    );
  }
}