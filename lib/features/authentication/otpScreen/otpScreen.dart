import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../featuresDriver/home/widgets/nextScreenButton.dart';
import '../login/screens/riderProfileSetup.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String sessionId;


  const OtpScreen({Key? key, required this.mobileNumber, required this.sessionId}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";
  bool isLoading = false;
  bool isResendingOtp = false;
  String? sessionId; // Store sessionId locally

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId; // Initialize with the widget's sessionId
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _sendOtp() async {
    setState(() => isResendingOtp = true);

    try {
      final response = await http.post(
        Uri.parse('http://13.49.117.190:7022/v1/auth/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': widget.mobileNumber}),
      );

      final responseData = jsonDecode(response.body);
      debugPrint("Send OTP Response: $responseData");

      if (responseData['success'] == true) {
        setState(() => sessionId = responseData['data']['sessionId']); // Update sessionId
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP sent successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Failed to send OTP')),
        );
      }
    } catch (e) {
      debugPrint("Error sending OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP')),
      );
    } finally {
      setState(() => isResendingOtp = false);
    }
  }

  Future<void> verifyOtp() async {
    if (otp.isEmpty || otp.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit numeric OTP')),
      );
      return;
    }

    if (sessionId == null || sessionId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session ID missing, please resend OTP')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://13.49.117.190:7022/v1/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': widget.mobileNumber,
          'otp': otp,
          'sessionId': sessionId,
        }),
      );

      final responseData = jsonDecode(response.body);
      debugPrint("OTP Verification Response: $responseData");

      if (responseData['success'] == true) {
        final token = responseData['data']['token'];
        if (token != null) await _storeToken(token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${responseData['message'] ?? 'OTP verification failed'}")),
        );
      }
    } catch (error) {
      debugPrint("Error verifying OTP: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while verifying OTP')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey;
    final buttonColor = const Color(0xFF211F96);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'OTP Verification',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Enter the code sent to\n${widget.mobileNumber}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // OTP Input
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              textStyle: TextStyle(fontSize: 20, color: textColor),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 55,
                fieldWidth: 45,
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                selectedColor: Colors.transparent,
                activeFillColor: isDarkMode
                    ? const Color(0xFF051A17)
                    : const Color(0xFFE6F5F3),
                inactiveFillColor: isDarkMode
                    ? const Color(0xFF051A17)
                    : const Color(0xFFE6F5F3),
                selectedFillColor: isDarkMode
                    ? const Color(0xFF051A17)
                    : const Color(0xFFE6F5F3),
              ),
              enableActiveFill: true,
              onChanged: (value) {
                setState(() => otp = value);
              },
            ),

            const SizedBox(height: 16),

            // Resend Code Button
            GestureDetector(
              onTap: isResendingOtp ? null : _sendOtp,
              child: Text(
                isResendingOtp ? "Resending..." : "Resend Code",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            const Spacer(),

            // Verify Button
            Nextscreenbutton(
              onPressed: () {
                if (otp.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid 6-digit numeric OTP'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  verifyOtp();
                }
              },
              buttonText: isLoading ? "Verifying..." : "Verify",
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
