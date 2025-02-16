import 'dart:convert';
import 'package:buzzcab/Constant/base_url.dart';
import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/signup/rider_signup/riderSignup.dart';
import 'package:buzzcab/featuresDriver/home/widgets/nextScreenButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

  void _sendOtp() async {
    if (passengerRoleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error: Role ID not found. Please restart the app.')),
      );
      return;
    }

    String mobileNumber = _phoneController.text.trim();

    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a 10-digit valid phone number')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(BaseUrl.register),
        headers: {
          'Authorization': '',
          'Content-Type': 'application/json',
          'slug': 'stage',
        },
        body: jsonEncode({
          "roleId": passengerRoleId,
          "mobile": mobileNumber,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        String sessionId = responseData['data']['sessionId'];
        print("mobileNumber:${mobileNumber}");
        print("sessionId:${sessionId}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpScreen(mobileNumber: mobileNumber, sessionId: sessionId),
          ),
        );
      } else if (responseData['message'] == "Mobile number already exists.") {
        _resendOtp(mobileNumber);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to send OTP: ${responseData['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending OTP. Please try again.')),
      );
    }
  }

  void _resendOtp(String mobileNumber) async {
    try {
      final resendResponse = await http.post(
        Uri.parse(BaseUrl.sendOtp),
        headers: {
          'Authorization': '',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "mobile": mobileNumber,
        }),
      );

      final resendData = jsonDecode(resendResponse.body);

      if (resendResponse.statusCode == 200) {
        String sessionId = resendData['data']['sessionId'];
        print("mobileNumber:${mobileNumber}");
        print("sessionId:${sessionId}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpScreen(mobileNumber: mobileNumber, sessionId: sessionId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to resend OTP: ${resendData['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error resending OTP. Please try again.')),
      );
    }
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
            child:
                Nextscreenbutton(onPressed: _sendOtp, buttonText: "Send OTP"),
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
                      color: const Color(0xFF211F96),
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
