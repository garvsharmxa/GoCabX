import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String location;
  final Color containerColor; // Container color parameter
  final Color iconColor; // Icon color parameter
  final Size size;

  const LocationInfo({
    required this.icon,
    required this.label,
    required this.location,
    required this.containerColor,
    required this.iconColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.01),
                decoration: BoxDecoration(
                  color: containerColor, // Use parameter for custom color
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: iconColor, size: size.width * 0.04),
              ),
              SizedBox(width: size.width * 0.01),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.033,
                  color: isDarkMode ? Colors.white70 : Colors.black87, // Dynamic text color
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            location,
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.035,
              // fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black, // Dynamic text color
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final String value;
  final Size size;

  const InfoSection({
    required this.title,
    required this.value,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white70 : Colors.black54, // Dynamic text color
            fontSize: size.width * 0.035,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black, // Dynamic text color
          ),
        ),
      ],
    );
  }
}
