import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({Key? key}) : super(key: key);

  @override
  _EnterMobileScreenState createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final TextEditingController _mobileController = TextEditingController(text: "+91 ");

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
              Row(
                children: [
                  
                  const SizedBox(width: 8), // Space between divider and text field
                  Expanded( // Fixes the layout issue
                    child: TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade800, // Darker gray for better contrast
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(color: Colors.grey.shade600), // Subtle hint color
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                     
                          setState(() {
                            _mobileController.text = "";
                            _mobileController.selection = TextSelection.fromPosition(
                              TextPosition(offset: _mobileController.text.length),
                            );
                          });
                        
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // Helper Text
              Text(
                'We’ll send an OTP for verification to get you started.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your navigation logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.blue : Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

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
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
