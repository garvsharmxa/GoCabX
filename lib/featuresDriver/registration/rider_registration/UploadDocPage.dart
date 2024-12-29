import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/widgets/nextScreenButton.dart';
import 'PhotoVerifyPage.dart';

class UploadDocPage extends StatefulWidget {
  const UploadDocPage({super.key});

  @override
  State<UploadDocPage> createState() => _UploadDocPageState();
}

class _UploadDocPageState extends State<UploadDocPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              RichText(
                text: TextSpan(
                  text: "Hi ",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Lorem",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1F9686),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ", Ready to Become a BuzzCab's Roadie?",
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),

              // Subtitle
              Text(
                "We're Excited to Have You on Board!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24),

              // Image
              Center(
                child: Image.asset(
                  "assets/images/content/driver_registration.png",
                  scale: 3,
                ),
              ),
              SizedBox(height: 40),

              // Title for Vehicle Registration
              Text(
                "Vehicle Registration Number",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),

              // Vehicle Registration Text Field
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  hintText: "Enter Vehicle Registration Number",
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white60 : Colors.black45,
                      fontSize: 14
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              SizedBox(height: 16),

              // Title for Year of Manufacture
              Text(
                "Year of Manufacture",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),

              // Year of Manufacture Text Field
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  hintText: "Enter Year of Manufacture",
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white60 : Colors.black45,
                    fontSize: 14
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              SizedBox(height: 24),

            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,20),
        child: Nextscreenbutton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoVerifyPage(),
              ),
            );
          },
          buttonText: 'Next',
        ),
      ),
    );
  }
}
