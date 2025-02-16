import 'dart:convert';
import 'package:buzzcab/Constant/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/widgets/login_signup/number_validation.dart';
import '../../../../featuresDriver/home/widgets/nextScreenButton.dart';
import '../../otpScreen/otpScreen.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({Key? key}) : super(key: key);

  @override
  _EnterMobileScreenState createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final TextEditingController _mobileController = TextEditingController();
  int? passengerRoleId;

  @override
  void initState() {
    super.initState();
    _loadPassengerRoleId();
  }

  Future<void> _loadPassengerRoleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passengerRoleId = prefs.getInt('passenger_role_id'); // Default to 3 if not found
    });
  }

  void _sendOtp() async {
    if (passengerRoleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Role ID not found. Please restart the app.')),
      );
      return;
    }

    String mobileNumber = _mobileController.text.trim();

    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 10-digit valid phone number')),
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
            builder: (context) => OtpScreen(mobileNumber: mobileNumber, sessionId: sessionId),
          ),
        );
      } else if (responseData['message'] == "Mobile number already exists.") {
        _resendOtp(mobileNumber);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${responseData['message']}')),
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
            builder: (context) => OtpScreen(mobileNumber: mobileNumber, sessionId: sessionId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend OTP: ${resendData['message']}')),
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
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter Your Mobile Number',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join BuzzCabs to book a ride in a minute',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Mobile Number',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        PhoneNumberValidator.countryCode,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          counterText: "", // Hides default counter
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Nextscreenbutton(
              onPressed: _sendOtp,
              buttonText: 'Next',
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {}, // Navigate to Roadie signup
              child: Text(
                'Sign up as Roadie',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.blue : Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
