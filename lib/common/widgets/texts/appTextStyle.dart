import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle h1(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, // Weight 600
      fontSize: 32.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle h2(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, // Weight 600
      fontSize: 28.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle h3(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, // Weight 600
      fontSize: 24.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle h4(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w500, // Weight 500
      fontSize: 20.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle h5(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w500, // Weight 500
      fontSize: 18.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle h6(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w500, // Weight 500
      fontSize: 16.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle text(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle label(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w400, // Weight 400
      fontSize: 12.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle caption(BuildContext context) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w400, // Weight 400
      fontSize: 10.0, // Adjust size as per your design
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }
}
