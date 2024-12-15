import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../common/widgets/button/actionButton.dart';
import 'onboardingSecond.dart';

class ChoosePathScreen extends StatelessWidget {
  const ChoosePathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(height: size.height /12),

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
                  onTap: () {},
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            SizedBox(height: size.height /15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/content/choosepath.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}