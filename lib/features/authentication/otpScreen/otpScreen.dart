import 'package:buzzcab/features/home/widgets/nextScreenButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../backendApiFloder/riderApiService/riderServiceEndpoints.dart';
import '../login/screens/riderPhotoUpload.dart';
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

  // Store the token in shared preferences
  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Method to send OTP
  Future<void> _sendOtp() async {
    setState(() {
      isResendingOtp = true; 
    });

    try {
      final response = await Riderserviceendpoints.sendOtp(widget.mobileNumber);
      print('Send OTP response: $response');
      setState(() {
        _sessionId = response['sessionid']; 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully')),
      );
    } catch (e) {
      print('Send OTP error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP')),
      );
    } finally {
      setState(() {
        isResendingOtp = false; // Hide loading for resend button
      });
    }
  }

  // Method to verify OTP
  Future<void> verifyOtp() async {
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() {
      isLoading = true; 
    });

    try {
      final response = await Riderserviceendpoints.verifyOtp(
        widget.mobileNumber,
        otp,
        _sessionId ?? '', // Use the current session ID
      );
      print('OTP verify response: $response');

      if (response['success'] == true) {
        final token = response['token'];
        if (token != null) {
          await _storeToken(token);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully')),
        );
        
      } else {
        final String msg = response['msg'] ?? 'Unknown error';
        print('OTP verification failed: $msg');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed: $msg')),
        );
      }
    } catch (error) {
      print('Error verifying OTP: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading for verify button
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey;
    final buttonColor = isDarkMode ? const Color(0xFF211F96) : const Color(0xFF211F96);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter the Code we’ve sent to ${widget.mobileNumber}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: hintTextColor,
              ),
            ),
            const SizedBox(height: 24),
            PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            textStyle: TextStyle(fontSize: 20, color: textColor),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeColor: Colors.transparent, 
              inactiveColor: Colors.transparent, 
              selectedColor: Colors.transparent, 
              activeFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3), // Background for active field
              inactiveFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3), // Background for inactive field
              selectedFillColor: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3), // Background for selected field
            ),
            enableActiveFill: true, // Ensure the background color is applied
            onChanged: (value) {
              otp = value; // Update OTP value
            },
          ),

            const SizedBox(height: 16),
            GestureDetector(
              onTap: isResendingOtp
                  ? null
                  : () {
                      _sendOtp(); // Call resend OTP
                    },
              child: Text(
                isResendingOtp ? "Resending..." : "Resend Code",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: buttonColor,
                 
                ),
              ),
            ),
            
           
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Nextscreenbutton(
          // onPressed: , 
          onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const ProfileSetupScreen()));
            },
            // onPressed: isLoading
            //     ? null
            //     : () {
            //         verifyOtp(); // Call verify OTP
                  // },
        buttonText: "Verify"),
      )
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: buttonColor,
      //       padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //     ),
      //     onPressed: (){
      //       Navigator.push(context, 
      //       MaterialPageRoute(builder: (context) => const ProfileSetupScreen()));
      //     },
      //     // onPressed: isLoading
      //     //     ? null
      //     //     : () {
      //     //         verifyOtp(); // Call verify OTP
      //     //       },
      //     child: isLoading
      //         ? const CircularProgressIndicator(color:  Color(0xFF211F96))
      //         : Text(
      //             'VERIFY',
      //             style: GoogleFonts.poppins(
      //               color: Colors.white,
      //               fontSize: 18,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //   ),
      // ),
            
    );
  }
}
