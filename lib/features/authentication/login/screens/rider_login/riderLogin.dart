import 'dart:convert';
import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/signup/rider_signup/riderSignup.dart';
import 'package:buzzcab/featuresDriver/home/widgets/nextScreenButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/widgets/colors/color.dart';
import '../../../otpScreen/otpScreen.dart';

class RiderLoginScreen extends StatefulWidget {
  const RiderLoginScreen({Key? key}) : super(key: key);

  @override
  _RiderLoginScreenState createState() => _RiderLoginScreenState();
}

class _RiderLoginScreenState extends State<RiderLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  int? passengerRoleId;

  @override
  void initState() {
    super.initState();
    _loadPassengerRoleId();
  }

  Future<void> _loadPassengerRoleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passengerRoleId =
          prefs.getInt('passenger_role_id'); // Default to 3 if not found
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/content/rider_signup.png", height: 150),
          const SizedBox(height: 16),
          Text(
            "Join as a Roadie today!",
            style: GoogleFonts.poppins(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            "Log in to start driving and earning",
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              color: textColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: BuzzcabTextField(
              labelText: "Phone Number",
              controller: _phoneController,
              isDarkMode: isDarkMode,
              keyboardType: TextInputType.phone,
              hintText: "Enter Your Phone Number",
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Nextscreenbutton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                          mobileNumber: "mobileNumber", sessionId: "sessionId"),
                    ),
                  );
                },
                buttonText: "Send OTP"),
          ),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RiderSignupScreen()),
              );
            },
            child: RichText(
              text: TextSpan(
                text: "New member? ",
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  color: textColor,
                ),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
