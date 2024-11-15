import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const OnboardingText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
