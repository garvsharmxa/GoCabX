import 'package:buzzcab/featuresDriver/onboradingScreen/rider_onboarding/riderOnboardingFirst.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/button/actionButton.dart';
import 'user_onboarding/onboardingSecond.dart';

class ChoosePathScreen extends StatelessWidget {
  final int passengerRoleId;
  final int driverRoleId;
  const ChoosePathScreen(
      {super.key, required this.passengerRoleId, required this.driverRoleId});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap Column inside a scrollable view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF25B29F),
                  child: Image.asset(
                    'assets/logos/applogo.png',
                    height: 40,
                    width: 40,
                  )),
              const SizedBox(height: 8.0),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Buzz',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F9686),
                      ),
                    ),
                    TextSpan(
                      text: 'Cabs',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff211F96),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Moving You Forward.....',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              SizedBox(height: size.height * 0.08), // Adjusted spacing

              // Choose your path text
              Text(
                'CHOOSE YOUR PATH',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
              const SizedBox(height: 24.0),

              // Option Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionCard(
                    title: 'Start as Rider',
                    icon: Icons.account_circle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingSecond(),
                        ),
                      );
                    },
                    isDarkMode: isDarkMode,
                  ),
                  ActionCard(
                    title: 'Drive as Roadie',
                    icon: Icons.attractions,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiderOnboardingFirst(),
                        ),
                      );
                    },
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05), // Adjusted spacing

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset(
                  'assets/images/content/choosepath.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20), // Added spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
