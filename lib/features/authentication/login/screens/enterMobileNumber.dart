import 'dart:convert';
import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/widgets/login_signup/number_validation.dart';
import '../../../../featuresDriver/home/widgets/nextScreenButton.dart';
import '../../otpScreen/otpScreen.dart';
import 'package:http/http.dart' as http;

class EnterMobileController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  var passengerRoleId = 3.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPassengerRoleId();
  }

  Future<void> _loadPassengerRoleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    passengerRoleId.value = prefs.getInt('passenger_role_id') ?? 3;
  }

}

class EnterMobileScreen extends StatelessWidget {
  final EnterMobileController controller = Get.put(EnterMobileController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back,
                    color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () => Get.back(),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter Your Mobile Number',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                'Join BuzzCabs to book a ride in a minute',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[700]),
              ),
              const SizedBox(height: 30),
              Text(
                'Mobile Number',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF051A17)
                      : const Color(0xFFE6F5F3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        PhoneNumberValidator.countryCode,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          hintStyle: TextStyle(
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
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
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          counterText: "", // Hides default counter
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Nextscreenbutton(
              onPressed: (){
                Get.to(() => OtpScreen(mobileNumber: "mobileNumber", sessionId: "sessionId"));
              },
              buttonText: 'Next',
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Sign up as Roadie',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.blue : Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
