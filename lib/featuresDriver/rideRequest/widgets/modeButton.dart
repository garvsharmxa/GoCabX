import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModeButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Size size;
  final VoidCallback onTap; // Callback for button tap

  const ModeButton({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(size.width * 0.06),
          border: Border.all(
            color: isSelected ? Colors.transparent : inactiveColor,
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : inactiveColor,
              size: size.width * 0.05,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : inactiveColor,
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
