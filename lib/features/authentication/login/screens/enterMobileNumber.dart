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
  final TextEditingController _mobileController =
  TextEditingController(text: PhoneNumberValidator.countryCode);

  void _sendOtp() async {
    final mobileNumber = _mobileController.text;
    if (PhoneNumberValidator.isValidPhoneNumber(mobileNumber)) {
      try {
        final response = await Riderserviceendpoints.sendOtp(mobileNumber);
        print('OTP sent successfully: $response');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(mobileNumber: mobileNumber),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 14, // 3 for +91 and 10 for number
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        border: InputBorder.none,
                        counterText: "", // Hides default counter
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
                        setState(() {}); // Updates custom counter below
                      },
                    ),

                    // Custom Counter Display
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${_mobileController.text.length - 3}/10',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
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
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(mobileNumber: "mobileNumber"),
                  ),
                );
              },
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