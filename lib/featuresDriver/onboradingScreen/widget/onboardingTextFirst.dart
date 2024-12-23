import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const OnboardingText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360.0;
    final double adjustedFontSize = isSmallScreen ? fontSize * 0.85 : fontSize; 

    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white 
        : Colors.black; 

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: adjustedFontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
