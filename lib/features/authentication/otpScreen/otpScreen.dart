import 'package:buzzcab/featuresDriver/home/widgets/nextScreenButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../featuresDriver/riderApiService/riderServiceEndpoints.dart';
import '../login/screens/riderProfileSetup.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";
  String? _sessionId;
  bool isLoading = false;
  bool isResendingOtp = false;

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _sendOtp() async {
    setState(() => isResendingOtp = true);

    try {
      final response = await Riderserviceendpoints.sendOtp(widget.mobileNumber);
      setState(() => _sessionId = response['sessionid']);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP')),
      );
    } finally {
      setState(() => isResendingOtp = false);
    }
  }

  Future<void> verifyOtp() async {
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await Riderserviceendpoints.verifyOtp(
        widget.mobileNumber, otp, _sessionId ?? '',
      );

      if (response['success'] == true) {
        final token = response['token'];
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
          SnackBar(content: Text(response['msg'] ?? 'OTP verification failed')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
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
                activeFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3),
                inactiveFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3),
                selectedFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3),
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
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
                );
              },
              // onPressed: isLoading ? null : verifyOtp,
              buttonText: isLoading ? "Verifying..." : "Verify",
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
