import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverRegStep1 extends StatefulWidget {
  const DriverRegStep1({super.key});

  @override
  State<DriverRegStep1> createState() => _DriverRegStep1State();
}

class _DriverRegStep1State extends State<DriverRegStep1> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Hi ",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Lorem",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1F9686),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ", Ready to Become a BuzzCab's Roadie?",
                    style: GoogleFonts.poppins(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "We're Excited to Have You on Board!",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                "assets/images/content/driver_registration.png",
                scale: 3,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Vehicle Details",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select Vehicle"),
          ],
        ),
      ),
    );
  }
}
