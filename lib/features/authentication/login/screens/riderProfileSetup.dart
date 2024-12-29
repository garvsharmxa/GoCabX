import 'package:buzzcab/features/authentication/login/screens/verificationCompleteScreen.dart';
import 'package:buzzcab/featuresDriver/home/widgets/nextScreenButton.dart';
import 'package:flutter/material.dart';

import 'riderPhotoUpload.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final inputFillColor = isDarkMode ? Colors.grey[850] : Colors.grey[200];
    final hintTextColor = isDarkMode ? Colors.grey[500] : Colors.grey[700];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complete Your Profile",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Enter your personal details to set up your account.",
              style: TextStyle(fontSize: 16.0, color: hintTextColor),
            ),
            const SizedBox(height: 32.0),
            _buildInputLabel("Your Name", textColor),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(child: _buildTextField("First Name", hintTextColor!, inputFillColor!)),
                const SizedBox(width: 16.0),
                Expanded(child: _buildTextField("Last Name", hintTextColor, inputFillColor!)),
              ],
            ),
            const SizedBox(height: 24.0),
            _buildInputLabel("Email Address", textColor),
            const SizedBox(height: 8.0),
            _buildTextField("Enter your email id", hintTextColor, inputFillColor, icon: Icons.email),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
        child: Nextscreenbutton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerificationCompleteScreen()),
            );
          },
          buttonText: "GET STARTED",
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label, Color textColor) {
    return Text(
      label,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: textColor),
    );
  }

  Widget _buildTextField(String hint, Color hintTextColor, Color fillColor, {IconData? icon}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: hintTextColor) : null,
        hintText: hint,
        hintStyle: TextStyle(color: hintTextColor),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
