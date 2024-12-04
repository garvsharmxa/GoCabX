import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../common/widgets/button/actionButton.dart';
import 'onboardingSecond.dart';

class ChoosePathScreen extends StatelessWidget {
  const ChoosePathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
                
                Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFF25B29F),
                      child: Image.asset('assets/logos/applogo.png',height: 40,width: 40,)
                      
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'BuzzCabs',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF1F9686),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Moving You Forward.....',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22.0),

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
                        
                      },
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),

                
                Center(
                  child: Lottie.asset(
                    // 'assets/images/animations/Animation_for_Switching_User_t_ Driver_Mode.json',
                    // 'assets/images/animations/New_Loading_Car_GIF.json',
                    // 'assets/images/animations/Splash-2Animation-Buzzcab.json',
                    // 'assets/images/animations/Splash-1Animation-Buzzcab.json',
                    'assets/images/animations/Intro_Screen_animation-BuzzCab.json',
                    width: double.infinity,
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
