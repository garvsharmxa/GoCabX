import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/featuresDriver/onboradingScreen/rider_onboarding/riderOnboardingSecond.dart';
import 'package:flutter/material.dart';
import '../../home/widgets/bottomButton.dart';
import '../widget/onboardingTextFirst.dart';

class RiderOnboardingFirst extends StatelessWidget {
  const RiderOnboardingFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black // Dark theme background color
          : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: Image.asset(
                    'assets/logos/applogo.png',
                    height: 40,
                    width: 40,
                  )),
              const SizedBox(height: 24),
              Text(
                'Welcome, Driver!',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              const OnboardingText(
                text: "Earn on your terms, every\nmile of the way.",
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/animations/welcome_roadie.png",
                    // scale: .5,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20, left: 20),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RiderOnboardingSecond()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: AppColors.primary.withOpacity(0.3),
            ).copyWith(
              elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return 8;
                  }
                  return 4;
                },
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

}


