
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../featuresDriver/riderApiService/riderServiceEndpoints.dart';
import '../../../../common/widgets/login_signup/number_validation.dart';
import '../../../../featuresDriver/home/widgets/nextScreenButton.dart';
import '../../otpScreen/otpScreen.dart';


class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({Key? key}) : super(key: key);

  @override
  _EnterMobileScreenState createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final TextEditingController _mobileController = TextEditingController(text: PhoneNumberValidator.countryCode);

  void _sendOtp() async {
    final mobileNumber = _mobileController.text;
    if (PhoneNumberValidator.isValidPhoneNumber(mobileNumber)) {
      try {
        final response = await Riderserviceendpoints.sendOtp(mobileNumber);
        // Handle the response (e.g., navigate to OTP screen, show success message)
        print('OTP sent successfully: $response');
        // Pass the mobile number to the OtpScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(mobileNumber: mobileNumber),
          ),
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${e.toString()}')),
        );
      }
    } else {
      // Show error for invalid phone number
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Enter Mobile No. To Sign Up',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),

              // Subtitle
              Text(
                'Join BuzzCabs to book ride in a minute',
                style: TextStyle(
                  fontSize: 16.0,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 24.0),

              // Mobile Number Input
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF051A17) : const Color(0xFFE6F5F3),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    hintText: 'Enter Mobile Number',
                    hintStyle: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (!value.startsWith(PhoneNumberValidator.countryCode)) {
                      setState(() {
                        _mobileController.text = PhoneNumberValidator.countryCode;
                        _mobileController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _mobileController.text.length),
                        );
                      });
                    }
                  },
                ),
              ),
              

              
              
              
            ],
          ),
        ),
      ),
    bottomNavigationBar:
     SizedBox(
  height: 70,
  width: double.infinity,
  child: Column(
    children: [
      // Make the ElevatedButton take the full width with a smaller height
      Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Nextscreenbutton(
          // onPressed: _sendOtp,
         onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpScreen(mobileNumber: '7764993094')),
                );
              },
         buttonText: 'Next',),
      ),
      

      // Signup as Roadie
      Center(
        child: GestureDetector(
          onTap: () {
            // Add navigation to Roadie signup screen
          },
          child: Text(
            'Signup as Roadie',
            style: TextStyle(
              fontSize: 14.0,
              color: isDarkMode ? Colors.blue : Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      
    ],
  ),
)

    );
  }
}
