import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButtonBar extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const GradientButtonBar({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [const Color(0xFF1F9686), const Color(0xFF211F96)]
                : [const Color(0xFF1F9686), const Color(0xFF211F96)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: GoogleFonts.montserrat(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[200] : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
