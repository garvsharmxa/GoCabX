import 'package:buzzcab/app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'BuzzCab',
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
      home: App()
    );
  }
}
