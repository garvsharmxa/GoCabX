import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuzzcabTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final String? prefixText;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final String Function(String?)? validator;
  final TextInputType keyboardType;
  final bool isDarkMode;
  final bool obscureText;

  const BuzzcabTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.controller,
    required this.isDarkMode,
    this.prefixText,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
            // prefixText: prefixText,
            // prefixStyle: GoogleFonts.poppins(
            //   color: Colors.grey.shade500,
            //   fontWeight: FontWeight.w500,
            // ),
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
