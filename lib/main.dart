import 'package:buzzcab/app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/Drawer/Screen/DrawerPage.dart';
import 'features/Drawer/Screen/FaqPage.dart';
import 'features/Help_Support/Screen/HelpAndSupportPage.dart'; // Import google_fonts

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'featuresDriver/Drawer/Screen/DrawerPage.dart';
import 'featuresDriver/Drawer/Screen/FaqPage.dart';
import 'featuresDriver/Help_Support/Screen/HelpAndSupportPage.dart'; // Import google_fonts

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.dart';
import 'featuresDriver/navigation_menu.dart';
import 'featuresRider/bottomNavigation.dart'; // Import google_fonts



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the primary color and color scheme to avoid repetition
    final Color primaryColor = const Color(0xFF1F9686);
    final Color secondaryColor = const Color(0xFF211F96); // Secondary color

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(), // Use Google Fonts
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor, // Define secondary color
        ),
        useMaterial3: true,
        brightness: Brightness.light, // Light mode
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts
            .montserratTextTheme(), // Use Google Fonts for dark theme
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor, // Define secondary color for dark mode
          brightness: Brightness.dark, // Dark mode
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home:

      //  OnboardingFirst(),

      // FaqPage(),
      App()
      // RiderNavigationMenu(),

      // const App(),

          //  OnboardingFirst(),



          // const App(),


    );
  }
}
